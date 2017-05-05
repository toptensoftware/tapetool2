using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Microbee
{
    [FileWriter("microbee.tapFileWriter", "Mirobee tape file writer", "tap", "Microbee tap file")]
    class TapFileWriter : StreamBase, IByteStream
    {
        public TapFileWriter()
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
            using (var br = new BinaryWriter(_stream, Encoding.UTF8, true))
            {
                // Write header
                br.Write("TAP_DGOS_MBEE".Select(x=>x).ToArray());
            }
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