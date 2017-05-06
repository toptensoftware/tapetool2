using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace tapetool2.Binary
{
    [FileReader("textBitStreamReader", "Text bit-stream file reader", ".bits.txt")]
    class TextBitStreamReader : StreamBase, IBitStream
    {
        public TextBitStreamReader()
        {
        }

        [FilterOption("filename", "The file to read", IsFileName = true)]
        public string Filename
        {
            get;
            set;
        }

        TextReader _reader;
        TextParser _parser;

        public override void Rewind()
        {
            // Base
            base.Rewind();

            Close();

            _reader = new StreamReader(Filename);
            _parser = new TextParser(_reader);
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield break;
        }

        bool _currentBit;

        public bool GetSample()
        {
            return _currentBit;
        }

        protected override bool OnNext()
        {
            char ch = _parser.Next();

            if (ch == '\0')
                return false;

            switch (ch)
            {
                case '1':
                    _currentBit = true;
                    break;

                case '0':
                    _currentBit = false;
                    break;

                default:
                    throw new InvalidDataException(string.Format("Invalid character in text bit-stream file: '{0}'", ch));
            }

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