using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Audio;
using tapetool2.Binary;
using tapetool2.Tape;

namespace tapetool2.Microbee
{
    [Filter("microbee.audioToBytes", "Parses an Microbee tape audio stream into a bytes")]
    class AudioToBytes : StreamBase, IByteStream, ISetUpstreamBaudRate
    {
        public AudioToBytes()
        {
        }

        IAudioStream _input;
    
        [InputStream]
        public IAudioStream Input
        {
            get { return _input; }
            set
            {
                _input = value;
            }
        }

        const int TAPE_SPEED_300 = 4;
        const int TAPE_SPEED_600 = 2;
        const int TAPE_SPEED_1200 = 1;

        public override void Rewind()
        {
            base.Rewind();

            _eof = !_input.Next();

            // 300 baud till proven otherwise
            SetBaudRate(_userBaud);

            // Minimum number of samples in a low frequency half cycle
            // Microbee PC85 ROM uses 1500Hz as the cut off for a low frequency cycle
            // ie: rom uses a count of 28 with high frequency cycles typically measuring 16 and 
            //     low frequency cycles typically measuring 32).
            _cutOffSamples = (_input.SampleRate / _cutoffFrequency) / 2;

            // Skip lead-in noise (wait for any signal outside the noise threshold)
            _input.Next();
            while (SignOfSample(_input.GetSample(0))==0)
            {
                _input.Next();
            };

            // Look for at least 16 short half cycles
            for (int i=0; i<16; i++)
            {
                while (ReadHalfCycleLength() >= _cutOffSamples)
                {
                    i = 0;
                }
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

        int _cutoffFrequency = 1500;

        [FilterOption("cutoffFrequency", "frequency cutoff between high and low frequency cycles (default=1500Hz)")]
        public int cutoffFrequency
        {
            set
            {
                _cutoffFrequency = value;
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
        bool _eof;
        int ReadHalfCycleLength()
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

        public byte ReadBit()
        {
            ReadHalfCycleLength();

            // Sum up cycle lengths
            int sum = 0;
            for (int i = 0; i < _tapeSpeed; i++)
            {
                sum += ReadHalfCycleLength();
            }

            if (_eof)
                return 0;

            sum /= _tapeSpeed;

            // What kind of bit?
            byte bit = (byte)((sum < _cutOffSamples) ? 0x80 : 0x00);

            // Skip the rest of the cycles
            int halfCyclesLeft = _tapeSpeed * (bit != 0 ? 4 : 2) - _tapeSpeed - 1;
            for (int i = 0; i < halfCyclesLeft; i++)
                ReadHalfCycleLength();

            // Return the bit
            return bit;
        }


        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        int _tapeSpeed;         // 1 = 1200, 2 = 600, 4 = 300
        int _cutOffSamples;
        byte _currentByte;

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
            while (ReadHalfCycleLength() >= _cutOffSamples)
            {
                // nop
            }

            // Skip short cycles at end of last byte
            while (ReadHalfCycleLength() < _cutOffSamples && !_eof)
            {
                // nop
            }

            // EOF?
            if (_eof)
                return false;

            var samplePos = ((StreamBase)_input).Position;

            // Skip the rest of the leading zero bit
            for (int i=0; i < _tapeSpeed * 2 - 1; i++)
            {
                ReadHalfCycleLength();
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
            switch (baudRate)
            {
                case 0:
                case 300:
                    _tapeSpeed = TAPE_SPEED_300;
                    break;

                case 600:
                    _tapeSpeed = TAPE_SPEED_600;
                    break;

                case 1200:
                    _tapeSpeed = TAPE_SPEED_1200;
                    break;

                default:
                    throw new InvalidOperationException(string.Format("Invalid baud rate ({0})", baudRate));
            }
        }
    }
}
