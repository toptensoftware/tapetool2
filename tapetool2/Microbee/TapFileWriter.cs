using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Microbee
{
    [FileWriter("microbee.tapFileWriter", "Mirobee tape file writer", "tap")]
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

        IByteStream _input;
        [InputStream]
        public IByteStream Input
        {
            get { return _input; }
            set { _input = value; }
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

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return Input;
        }

        public byte GetByte()
        {
            return _input.GetByte();
        }

        public override bool Next()
        {
            if (!_input.Next())
                return false;
            _stream.WriteByte(_input.GetByte());
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