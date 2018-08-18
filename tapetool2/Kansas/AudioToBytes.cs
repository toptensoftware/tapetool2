using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Audio;
using tapetool2.Binary;
using tapetool2.Tape;

namespace tapetool2.Kansas
{
    [Filter("kansas.audioToBytes", "Parses an Kansas City tape audio stream into a bytes")]
    class AudioToBytes : StreamBase, IByteStream, ISetUpstreamBaudRate
    {
        public AudioToBytes()
        {
        }

        protected IAudioStream _input;

        FormatSpec _formatSpec = FormatSpec.KansasCity;
        public void SetFormatSpec(FormatSpec spec)
        {
            _formatSpec = spec;
        }

        [InputStream]
        public IAudioStream Input
        {
            get { return _input; }
            set
            {
                _input = value;
            }
        }

        public override void Rewind()
        {
            base.Rewind();

            _eof = !_input.Next();

            // 300 baud till proven otherwise
            SetBaudRate(_userBaud);

            // Skip lead-in noise (wait for any signal outside the noise threshold)
            _input.Next();
            while (!_eof && SignOfSample(_input.GetSample(0))==0)
            {
                _input.Next();
            };

            // Load the first half cycle
            NextHalfCycle();

            // Wait for at least one of each audio cycle kind
            bool haveLow = false, haveHigh = false;
            while (!_eof && !(haveLow && haveHigh))
            {
                if (CurrentHalfCycleKind() == HalfCycleKind.High)
                    haveHigh = true;
                if (CurrentHalfCycleKind() == HalfCycleKind.Low)
                    haveLow = true;
                NextHalfCycle();
            }

            // Look for the tail bits pattern
            // NB: For normal 300 baud, this should be 32 high frequency half cycles 
            //  (which corresponds to two 1-bits)
            for (int i=0; i<_tailBitPattern.Count && !_eof; i++)
            {
                if (CurrentHalfCycleKind() != _tailBitPattern[i])
                {
                    i = -1;
                }
                NextHalfCycle();
            }
        }

        float _noiseThreshold = 0.05f;

        [FilterOption("noiseThreshold", "filter noise below this level (default=0.05)")]
        public float noiseThreshold
        {
            set
            {
                _noiseThreshold = value;
            }
        }

        int _userBaud = 0;
        [FilterOption("baud", "baud rate (deafult=0=auto, 300, 600 or 1200)")]
        public int baud
        {
            set
            {
                _userBaud = value;
            }
        }

        [FilterOption("trace", "trace mode")]
        public bool Trace
        {
            get;
            set;
        }


        // Work out the sign of a sample, allowing for noise threshold around the center
        int SignOfSample(float sample)
        {
            if (sample > _noiseThreshold)
                return 1;
            if (sample < -_noiseThreshold)
                return -1;
            return 0;
        }

        // Measure the length of the next half cycle
        // (ie: number of samples before sign of current sample changes)
        protected bool _eof;
        protected int _ReadHalfCycleLength()
        {
            if (_eof)
                return -1;

            // Get the current sample
            int startSample = SignOfSample(_input.GetSample(0));

            // Count how many samples until sample sign changes
            int halfCycleLength = 0;
            while (_input.Next())
            {
                halfCycleLength++;
                int currentSample = SignOfSample(_input.GetSample(0));
                if (currentSample != startSample && currentSample!=0)
                {
                    return halfCycleLength;
                }
            }

            // Remember eof
            _eof = true;
            return halfCycleLength;
        }

        int _currentHalfCycleLength;
        int NextHalfCycle()
        {
            _currentHalfCycleLength = _ReadHalfCycleLength();
            return _currentHalfCycleLength;
        }

        HalfCycleKind CurrentHalfCycleKind()
        {
            if (_currentHalfCycleLength < 0)
                return HalfCycleKind.TooHigh;
            return _currentHalfCycleLength < _cutOffSamples ? HalfCycleKind.High : HalfCycleKind.Low;
        }

        public virtual byte ReadBit()
        {
            // Sum up cycle lengths
            int sum = 0;
            for (int i = 0; i < _cycleSumCount; i++)
            {
                sum += _currentHalfCycleLength;
                NextHalfCycle();
            }

            if (_eof)
                return 0;

            // What kind of bit?
            byte bit;
            if (sum < _cutOffSamples * _cycleSumCount)
            {
                bit = _highFreqBit;
            }
            else
            {
                bit = _lowFreqBit;
            }

            // Skip the rest of the cycles
            int cyclesRemaining = (bit == 0 ? _baudSpec.ZeroBitHalfCycleCount : _baudSpec.OneBitHalfCycleCount) - _cycleSumCount;
            for (int i = 0; i < cyclesRemaining; i++)
                NextHalfCycle();

            // Return the bit
            return bit;
        }


        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        protected BaudSpec _baudSpec;
        List<HalfCycleKind> _leadBitPattern;
        List<HalfCycleKind> _tailBitPattern;
        int _cycleSumCount;
        byte _highFreqBit;
        byte _lowFreqBit;

        protected int _cutOffSamples;
        protected byte _currentByte;
        HalfCycleKind _byteSyncCycleKind1;
        HalfCycleKind _byteSyncCycleKind2;

        public int GetCurrentBaudRate()
        {
            // We don't know!
            return 0;
        }

        public byte GetByte()
        {
            return _currentByte;
        }

        protected override bool OnNext()
        {
            _currentByte = 0xFF;

            if (_eof)
                return false;

            // Skip any long cycles - should never happen as we should already be
            // in the tail cycles of the last byte, but this might help to resync
            if (_byteSyncCycleKind1 != HalfCycleKind.Indeterminate)
            {
                while (CurrentHalfCycleKind() == _byteSyncCycleKind1)
                {
                    NextHalfCycle();
                }
            }

            // Skip the tail bits of the previous byte
            if (_byteSyncCycleKind2 != HalfCycleKind.Indeterminate)
            {
                while (CurrentHalfCycleKind() == _byteSyncCycleKind2)
                {
                    NextHalfCycle();
                }
            }

            // EOF?
            if (_eof)
                return false;

            var samplePos = ((StreamBase)_input).Position;

            // Skip the lead bit pattern
            for (int i = 0; i < _leadBitPattern.Count; i++)
            {
                if (CurrentHalfCycleKind() != _leadBitPattern[i])
                {
                    Console.WriteLine("Warning: lead bit pattern mismatch, ignoring");
                }
                NextHalfCycle();
            }

            // Read 8 bits
            for (int i=0; i<8; i++)
            {
                if (_eof)
                    return false;

                var sp = ((StreamBase)_input).Position;
                _currentByte = (byte)(ReadBit() | (_currentByte >> 1));
                if (Trace)
                    Console.WriteLine("Read bit {0:X2} from sample {1}", (_currentByte & 0x80)!=0 ? '1' : '0', sp);
            }

            if (Trace)
                Console.WriteLine("Read byte #{0} as {1:X2} from sample {2}", Position, _currentByte, samplePos);

            // Got the byte!
            return true;
        }

        public override void WriteSummary(TextWriter w)
        {
            base.WriteSummary(w);
        }

        public void SetUpstreamBaudRate(int baudRate)
        {
            // Ignore if set by user
            if (_userBaud != 0)
                return;

            // Set it
            SetBaudRate(baudRate);
        }

        void SetBaudRate(int baudRate)
        {
            // Get the baud spec
            _baudSpec = _formatSpec.GetBaudSpec(baudRate == 0 ? 300 : baudRate);

            // Must have lead and tail bits
            if (_baudSpec.leadBits.Length < 1 ||
                _baudSpec.tailBits.Length < 1)
                throw new InvalidOperationException("Unsupported lead/tail bit specification");

            // Lead and tail bits must be different
            if (_baudSpec.leadBits[0] == _baudSpec.tailBits[0])
                throw new InvalidOperationException("Unsupported lead/tail bit specification");

            // All the lead bits must be the same
            if (_baudSpec.leadBits.Distinct().Count() != 1)
                throw new InvalidOperationException("Unsupported lead/tail bit specification");

            // All the tail bits must be the same
            if (_baudSpec.tailBits.Distinct().Count() != 1)
                throw new InvalidOperationException("Unsupported lead/tail bit specification");

            // Minimum number of samples in a low frequency half cycle
            // Microbee PC85 ROM uses 1500Hz as the cut off for a low frequency cycle
            // ie: rom uses a count of 28 with high frequency cycles typically measuring 16 and 
            //     low frequency cycles typically measuring 32).
            _cutOffSamples = (_input.SampleRate / (_baudSpec.LowFrequency * 3 / 2)) / 2;

            // Work out the cycle kinds to skip at the start of each byte to resync
            _byteSyncCycleKind1 = _baudSpec.leadBits[0] ? _baudSpec.OneBitHalfCycleKind : _baudSpec.ZeroBitHalfCycleKind;
            _byteSyncCycleKind2 = _baudSpec.tailBits[0] ? _baudSpec.OneBitHalfCycleKind : _baudSpec.ZeroBitHalfCycleKind;

            // Work out the lead bit pattern
            _leadBitPattern = new List<HalfCycleKind>();
            for (int i = 0; i < _baudSpec.leadBits.Length; i++)
            {
                if (_baudSpec.leadBits[i])
                {
                    _leadBitPattern.AddRange(Enumerable.Repeat<HalfCycleKind>(_baudSpec.OneBitHalfCycleKind, _baudSpec.OneBitHalfCycleCount));
                }
                else
                {
                    _leadBitPattern.AddRange(Enumerable.Repeat<HalfCycleKind>(_baudSpec.ZeroBitHalfCycleKind, _baudSpec.ZeroBitHalfCycleCount));
                }
            }

            // Work out the tail bit pattern
            _tailBitPattern = new List<HalfCycleKind>();
            for (int i = 0; i < _baudSpec.tailBits.Length; i++)
            {
                if (_baudSpec.tailBits[i])
                {
                    _tailBitPattern.AddRange(Enumerable.Repeat<HalfCycleKind>(_baudSpec.OneBitHalfCycleKind, _baudSpec.OneBitHalfCycleCount));
                }
                else
                {
                    _tailBitPattern.AddRange(Enumerable.Repeat<HalfCycleKind>(_baudSpec.ZeroBitHalfCycleKind, _baudSpec.ZeroBitHalfCycleCount));
                }
            }

            if (_baudSpec.OneBitHalfCycleKind == HalfCycleKind.High)
            {
                _highFreqBit = 0x80;
                _lowFreqBit = 0x00;
            }
            else
            {
                _highFreqBit = 0x00;
                _lowFreqBit = 0x80;
            }


            if (_baudSpec.OneBitHalfCycleCount < _baudSpec.ZeroBitHalfCycleCount)
            {
                _cycleSumCount = _baudSpec.OneBitHalfCycleCount / 2;
            }
            else
            {
                _cycleSumCount = _baudSpec.ZeroBitHalfCycleCount / 2;
            }
            if (_cycleSumCount < 1)
                _cycleSumCount = 1;
        }
    }
}
