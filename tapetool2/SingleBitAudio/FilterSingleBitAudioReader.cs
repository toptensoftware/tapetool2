using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [FileReader("singleBitAudioReader", "Single bit audio file reader", "sba", "Single bit audio stream")]
    class FilterSingleBitAudioReader : FilterAudio
    {
        public FilterSingleBitAudioReader()
        {
        }

        public string Filename
        {
            get;
            set;
        }

        float _highLevel;
        float _lowLevel;

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

        public override IEnumerable<Filter> GetPrecedents()
        {
            yield break;
        }

        public override int SampleRate
        {
            get
            {
                return _sampleRate;
            }
        }

        public override int ChannelCount
        {
            get
            {
                return 1;
            }
        }

        public override int BitsPerSample
        {
            get
            {
                return 1;
            }
        }

        public override float GetSample(int channel)
        {
            return (_unreadBits & 0x01)!= 0 ? _highLevel : _lowLevel;
        }

        public override bool Next()
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
    }
}
