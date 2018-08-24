using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace tapetool2.Tape
{
    [FileReader("textHalfCycleKindReader", "Text half-cycle-kind file reader", ".halfcycles.txt")]
    class TextHalfCycleKindReader : StreamBase, IHalfCycleKindStream
    {
        public TextHalfCycleKindReader()
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

        HalfCycleKind _currentHalfCycleKind;

        public HalfCycleKind GetHalfCycleKind()
        {
            return _currentHalfCycleKind;
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
                    _currentHalfCycleKind = HalfCycleKind.High;
                    break;

                case 'L':
                    _currentHalfCycleKind = HalfCycleKind.Low;
                    break;

                case '<':
                    _currentHalfCycleKind = HalfCycleKind.TooHigh;
                    break;

                case '>':
                    _currentHalfCycleKind = HalfCycleKind.TooLow;
                    break;

                case '?':
                    _currentHalfCycleKind = HalfCycleKind.Indeterminate;
                    break;

                default:
                    throw new InvalidDataException(string.Format("Invalid character in text half-cycles file: '{0}'", ch));
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