using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [FileWriter("textCycleKindWriter", "Text cycle-kind file writer", "txt", "Text file")]
    class FilterTextCycleKindWriter : FilterCycleKindStream
    {
        public FilterTextCycleKindWriter()
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



        FilterCycleKindStream _source;
        [Source]
        public FilterCycleKindStream Source
        {
            get { return _source; }
            set { _source = value; }
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
            _tw.WriteLine("[cycle kinds]");
            _position = 0xFFFFFFFF;
            _prevBaudRate = 0;

        }

        public override IEnumerable<Filter> GetPrecedents()
        {
            yield return Source;
        }

        public override CycleKind GetCycleKind()
        {
            return _source.GetCycleKind();
        }

        public override int GetCurrentBaudRate()
        {
            return _source.GetCurrentBaudRate();
        }

        public override bool Next()
        {
            if (!_source.Next())
            {
                _tw.WriteLine("\n\n[EOF]");
                return false;
            }

            var br = _source.GetCurrentBaudRate();
            if (br != _prevBaudRate)
            {
                _tw.Write("[baud:{0}]", br);
                _prevBaudRate = br;
            }

            _position++;

            if ((_position % _perLine) == 0)
                _tw.Write("\n[{0,10}] ", _position);

            if (_grouping != 0 && ((_position % _perLine) % _grouping) == 0)
            {
                _tw.Write(" ");
            }

            var ch = '?';
            switch (_source.GetCycleKind())
            {
                case CycleKind.High:
                    ch = 'S';
                    break;

                case CycleKind.Low:
                    ch = 'L';
                    break;

                case CycleKind.TooHigh:
                    ch = '<';
                    break;

                case CycleKind.TooLow:
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
