using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Binary
{
    [FileWriter("binWriter", "Binary file writer", "bin", "Binary file")]
    class BinaryWriter : StreamBase, IByteStream
    {
        public BinaryWriter()
        {
        }

        [FilterOption("filename", "The file to write", IsFileName = true)]
        public string Filename
        {
            get;
            set;
        }

        IByteStream _source;
        [Source]
        public IByteStream Source
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

        public override IEnumerable<IStream> GetPrecedents()
        {
            yield return Source;
        }

        public byte GetByte()
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
