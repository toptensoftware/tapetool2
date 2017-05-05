using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.SingleBitAudio
{
    [FileWriter("singleBitAudioWriter", "Single bit audio file writer", "sba")]
    class SingleBitAudioWriter : StreamBase, IAudioStream
    {
        public SingleBitAudioWriter()
        {
        }

        IAudioStream _input;

        [InputStream]
        public IAudioStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        [FilterOption("filename", "The file to write", IsFileName = true)]
        public string Filename
        {
            get;
            set;
        }

        float _threshold = 0.0f;

        [FilterOption("threshold", "audio level threshold for bit value 1")]
        public float Threshold
        {
            get { return _threshold; }
            set { _threshold = value; }
        }



        FileStream _stream;
        BinaryWriter _binaryWriter;
        int _unwrittenBitCount;
        byte _unwrittenBits;
        uint _totalSamples;

        public override void Rewind()
        {
            base.Rewind();

            Close();

            _unwrittenBitCount = 0;
            _unwrittenBits = 0;
            _totalSamples = 0;

            _stream = File.Create(Filename);
            _binaryWriter = new BinaryWriter(_stream, Encoding.UTF8, true);
            _binaryWriter.Write(BitStreamUtils.Signature);
            _binaryWriter.Write((uint)SampleRate);
            _binaryWriter.Write((uint)0);
            _binaryWriter.Write((uint)0);
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        public int SampleRate
        {
            get
            {
                return _input.SampleRate;
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
            return _input.GetSample(channel);
        }

        public override bool Next()
        {
            if (!_input.Next())
                return false;

            // Write the current bit
            _unwrittenBits = (byte)(_unwrittenBits >> 1 | (GetSample(0) >= _threshold ? 0x80 : 0x00));
            _unwrittenBitCount++;
            if (_unwrittenBitCount == 8)
            {
                _stream.WriteByte(_unwrittenBits);
                _unwrittenBitCount = 0;
                _unwrittenBits = 0;
            }

            _totalSamples++;

            return true;
        }


        void Close()
        {
            if (_stream != null)
            {
                // Flush the last byte
                if (_unwrittenBitCount > 0)
                {
                    _unwrittenBits >>= (8 - _unwrittenBitCount);
                    _stream.WriteByte(_unwrittenBits);
                }

                // Back fill the total number of samples
                _stream.Position = 8;
                _binaryWriter.Write((uint)_totalSamples);

                // Close
                _binaryWriter.Dispose();
                _binaryWriter = null;
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