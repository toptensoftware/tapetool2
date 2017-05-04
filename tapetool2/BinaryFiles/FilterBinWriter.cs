using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [FileWriter("binWriter", "Binary file writer", "bin", "Binary file")]
    class FilterBinWriter : FilterByteStream
    {
        public FilterBinWriter()
        {
        }

        [FilterOption("filename", "The file to write", IsFileName = true)]
        public string Filename
        {
            get;
            set;
        }

        FilterByteStream _source;
        [Source]
        public FilterByteStream Source
        {
            get { return _source; }
            set { _source = value; }
        }

        FileStream _stream;

        public override void Rewind()
        {
            // Base
            base.Rewind();

            // Close
            Close();

            // Open source stream
            _stream = File.Create(Filename);
        }

        public override IEnumerable<Filter> GetPrecedents()
        {
            yield return Source;
        }

        public override byte GetByte()
        {
            return _source.GetByte();
        }

        public override bool Next()
        {
            if (!_source.Next())
                return false;
            _stream.WriteByte(_source.GetByte());
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
