using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [FileReader("binReader", "Binary file reader", "bin", "Binary file")]
    class FilterBinReader : FilterByteStream
    {
        public FilterBinReader()
        {
        }

        [FilterOption("filename", "The file to read", IsFileName = true)]
        public string Filename
        {
            get;
            set;
        }

        FileStream _stream;
        byte _currentByte;

        public override void Rewind()
        {
            // Base
            base.Rewind();

            // Close
            Close();

            // Open source stream
            _stream = File.OpenRead(Filename);
        }

        public override IEnumerable<Filter> GetPrecedents()
        {
            yield break;
        }


        public override byte GetByte()
        {
            return _currentByte;
        }

        public override bool Next()
        {
            if (_stream.Position >= _stream.Length)
                return false;
            _currentByte = (byte)_stream.ReadByte();
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
