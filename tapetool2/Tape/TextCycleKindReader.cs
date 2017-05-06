using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace tapetool2.Tape
{
    [FileReader("textCycleKindReader", "Text cycle-kind file reader", ".cycles.txt")]
    class TextCycleKindReader : StreamBase, ICycleKindStream
    {
        public TextCycleKindReader()
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

        CycleKind _currentCycleKind;

        public CycleKind GetCycleKind()
        {
            return _currentCycleKind;
        }

        public int GetCurrentBaudRate()
        {
            return 0;
        }

        protected override bool OnNext()
        {
            char ch = _parser.Next();

            if (ch == '\0')
                return false;

            switch (ch)
            {
                case 'S':
                    _currentCycleKind = CycleKind.High;
                    break;

                case 'L':
                    _currentCycleKind = CycleKind.Low;
                    break;

                case '<':
                    _currentCycleKind = CycleKind.TooHigh;
                    break;

                case '>':
                    _currentCycleKind = CycleKind.TooLow;
                    break;

                case '?':
                    _currentCycleKind = CycleKind.Indeterminate;
                    break;

                default:
                    throw new InvalidDataException(string.Format("Invalid character in text cycles file: '{0}'", ch));
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