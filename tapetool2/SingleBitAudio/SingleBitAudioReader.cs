using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Audio;

namespace tapetool2.SingleBitAudio
{
    [FileReader("singleBitAudioReader", "Single bit audio file reader", "sba")]
    class SingleBitAudioReader : StreamBase, IAudioStream
    {
        public SingleBitAudioReader()
        {
        }

        [FilterOption("filename", "The file to write", IsFileName = true)]
        public string Filename
        {
            get;
            set;
        }

        float _highLevel = 0.75f;
        float _lowLevel = -0.75f;

        [FilterOption("high", "Audio level for 1 bits (default=0.75)")]
        public float HighLevel
        {
            get { return _highLevel; }
            set { _highLevel = value; }
        }

        [FilterOption("low", "Audio level for 0 bits (default=-0.75")]
        public float LowLevel
        {
            get { return _lowLevel; }
            set { _lowLevel = value; }
        }


        public override void Rewind()
        {
            base.Rewind();

            // Close
            Close();

            // Open file
            _stream = File.OpenRead(Filename);
            using (var br = new BinaryReader(_stream, Encoding.UTF8, true))
            {
                if (br.ReadUInt32() != BitStreamUtils.Signature)
                    throw new InvalidDataException("Not a bitstream file");
                _sampleRate = br.ReadInt32();
                _totalSamples = br.ReadUInt32();
                br.ReadUInt32();
            }

            // Reset counters
            _currentSample = 0;
            _unreadBits = 0;
            _unreadBitCount = 0;
        }

        FileStream _stream;
        int _sampleRate;
        uint _currentSample;
        uint _totalSamples;
        byte _unreadBits;
        int _unreadBitCount;

        public override IEnumerable<IStream> EnumStreams()
        {
            yield break;
        }

        public int SampleRate
        {
            get
            {
                return _sampleRate;
            }
        }

        public int ChannelCount
        {
            get
            {
                return 1;
            }
        }

        public int BitsPerSample
        {
            get
            {
                return 1;
            }
        }

        public float GetSample(int channel)
        {
            return (_unreadBits & 0x01)!= 0 ? _highLevel : _lowLevel;
        }

        protected override bool OnNext()
        {
            if (_currentSample >= _totalSamples)
                return false;

            if (_unreadBitCount > 0)
            {
                _unreadBitCount--;
                _unreadBits >>= 1;
            }

            if (_unreadBitCount == 0)
            {
                _unreadBits = (byte)_stream.ReadByte();
                _unreadBitCount = 8;
            }

            _currentSample++;
            return true;
        }

        void Close()
        {
            if (_stream != null)
            {
                _stream.Dispose();
                _stream = null;
            }
        }

        public override void Dispose()
        {
            Close();
            base.Dispose();
        }

        public override void WriteSummary(TextWriter w)
        {
            base.WriteSummary(w);
            w.WriteLine("    total samples: {0}", _totalSamples);
            w.WriteLine("    sample rate: {0}Hz", _sampleRate);
        }
    }
}
