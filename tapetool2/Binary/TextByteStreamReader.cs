using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace tapetool2.Binary
{
    [FileReader("textByteStreamReader", "Text byte-stream file reader", ".bytes.txt")]
    class TextByteStreamReader : StreamBase, IByteStream
    {
        public TextByteStreamReader()
        {
        }

        [FilterOption("filename", "The file to read", IsFileName = true)]
        public string Filename
        {
            get;
            set;
        }

        TextReader _reader;
        TextCharParser _parser;

        public override void Rewind()
        {
            // Base
            base.Rewind();

            Close();

            _reader = new StreamReader(Filename);
            _parser = new TextCharParser(_reader);
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield break;
        }

        byte _currentByte;

        public byte GetByte()
        {
            return _currentByte;
        }

        public byte ParseNibble(char ch)
        {
            if (ch >= '0' && ch <= '9')
                return (byte)(ch - '0');
            if (ch >= 'a' && ch <= 'f')
                return (byte)(ch -'a' + 0x0A);
            if (ch >= 'A' && ch <= 'F')
                return (byte)(ch -'A' + 0x0A);

            if (ch == '\0')
                throw new InvalidOperationException("Unexpected mid-byte eof in text byte stream");
            throw new InvalidOperationException(string.Format("Invalid character in text byte stream ('{0}')", ch));
        }

        protected override bool OnNext()
        {
            char ch = _parser.Next();

            if (ch == '\0')
                return false;

            byte nibHigh = ParseNibble(ch);

            ch = _parser.Next();

            _currentByte = (byte)(nibHigh << 4 | ParseNibble(ch));

            return true;
        }

        void Close()
        {
            if (_reader!=null)
            {
                _parser = null;
                _reader.Dispose();
                _reader = null;
            }
        }

        public override void Dispose()
        {
            Close();
            base.Dispose();
        }
    }
}     