using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [FileWriter("singleBitAudioWriter", "Single bit audio file writer", "sba", "Single bit audio stream")]
    class FilterSingleBitAudioWriter : FilterSingleBitAudioStream
    {
        public FilterSingleBitAudioWriter(string filename, FilterSingleBitAudioStream source)
        {
            Filename = filename;
            _source = source;
        }

        FilterSingleBitAudioStream _source;

        [Source]
        public FilterSingleBitAudioStream Source
        {
            get { return _source; }
            set { _source = value; }
        }

        public string Filename
        {
            get;
            set;
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

        public override IEnumerable<Filter> GetPrecedents()
        {
            yield return _source;
        }

        public override int SampleRate
        {
            get
            {
                return _source.SampleRate;
            }
        }

        public override bool GetSample()
        {
            return _source.GetSample();
        }

        public override bool Next()
        {
            if (!_source.Next())
                return false;

            // Write the current bit
            _unwrittenBits = (byte)(_unwrittenBits >> 1 | (GetSample() ? 0x80 : 0x00));
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
