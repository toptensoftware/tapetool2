using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace tapetool2.Tape
{
    [FileWriter("textHalfCycleKindWriter", "Text half-cycle-kind file writer", ".halfcycles.txt")]
    class TextHalfCycleKindWriter : StreamBase, IHalfCycleKindStream
    {
        public TextHalfCycleKindWriter()
        {
        }

        [FilterOption("filename", "The file to write", IsFileName = true)]
        public string Filename
        {
            get;
            set;
        }

        [FilterOption("perLine", "The number of elements to render per line")]
        public int PerLine
        {
            set { _perLine = (uint)value; }
        }

        [FilterOption("grouping", "The number of elements to group together")]
        public int Grouping
        {
            set { _grouping = (uint)value; }
        }

        [FilterOption("raw", "Raw data only")]
        public bool Raw
        {
            get;
            set;
        }

        IHalfCycleKindStream _input;
        [InputStream]
        public IHalfCycleKindStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        TextWriter _tw;
        uint _grouping = 0;
        uint _position = 0xFFFFFFFF;
        uint _perLine = 80;
        int _prevBaudRate = 0;

        public override void Rewind()
        {
            // Base
            base.Rewind();

            Close();

            _tw = new StreamWriter(Filename);
            if (!Raw)
                _tw.WriteLine("[half-cycle kinds]");
            _position = 0xFFFFFFFF;
            _prevBaudRate = 0;

        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return Input;
        }

        public HalfCycleKind GetHalfCycleKind()
        {
            return _input.GetHalfCycleKind();
        }

        public int GetCurrentBaudRate()
        {
            return _input.GetCurrentBaudRate();
        }

        protected override bool OnNext()
        {
            if (!_input.Next())
            {
                if (!Raw)
                    _tw.WriteLine("\n\n[EOF]");
                return false;
            }

            var br = _input.GetCurrentBaudRate();
            if (br != _prevBaudRate)
            {
                if (!Raw)
                    _tw.Write("[baud:{0}]", br);
                _prevBaudRate = br;
            }

            _position++;

            if ((_position % _perLine) == 0)
            {
                if (Raw)
                    _tw.Write("\n");
                else
                    _tw.Write("\n[{0,10}] ", _position);
            }

            if (_grouping != 0 && ((_position % _perLine) % _grouping) == 0)
            {
                _tw.Write(" ");
            }

            var ch = '?';
            switch (_input.GetHalfCycleKind())
            {
                case HalfCycleKind.High:
                    ch = 'S';
                    break;

                case HalfCycleKind.Low:
                    ch = 'L';
                    break;

                case HalfCycleKind.TooHigh:
                    ch = '<';
                    break;

                case HalfCycleKind.TooLow:
                    ch = '>';
                    break;
            }

            _tw.Write(ch);
            return true;
        }

        void Close()
        {
            if (_tw != null)
            {
                _tw.Write("\n\n");
                _tw.Dispose();
                _tw = null;
            }
        }

        public override void Dispose()
        {
            Close();
            base.Dispose();
        }
    }
}     