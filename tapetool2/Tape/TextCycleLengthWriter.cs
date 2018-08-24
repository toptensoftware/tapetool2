using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace tapetool2.Tape
{
    [FileWriter("textCycleLengthWriter", "Text cycle-length file writer", ".cyclelen.txt")]
    class TextCycleLengthWriter : StreamBase, ICycleLengthStream
    {
        public TextCycleLengthWriter()
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
            set { _perLine = value; }
        }

        [FilterOption("raw", "Raw data only")]
        public bool Raw
        {
            get;
            set;
        }

        ICycleLengthStream _input;
        [InputStream]
        public ICycleLengthStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        TextWriter _tw;
        int _position = -1;
        int _perLine = 30;
        int _lastCycleSampleNumber = 0;

        public override void Rewind()
        {
            // Base
            base.Rewind();

            Close();

            _tw = new StreamWriter(Filename);
            if (!Raw)
            {
                _tw.WriteLine("[cycle lengths]\n");
                _tw.WriteLine($"[sample rate] {_input.SampleRate}\n");
                _tw.WriteLine($"[{"sample",10} {"cycle#",10}]");
            }
            else
            {
                _tw.WriteLine(_input.SampleRate);
            }
            _position = -1;
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return Input;
        }

        public int CurrentCycleLength => _input.CurrentCycleLength;
        public int SampleRate => _input.SampleRate;

        protected override bool OnNext()
        {
            if (!_input.Next())
            {
                if (!Raw)
                    _tw.WriteLine("\n\n[EOF]");
                return false;
            }

            _position++;

            if ((_position % _perLine) == 0)
            {
                if (Raw)
                    _tw.Write("\n");
                else
                    _tw.Write("\n[{0,10} {1,10}] ", _lastCycleSampleNumber, _position);
            }

            _lastCycleSampleNumber += _input.CurrentCycleLength;


            _tw.Write(_input.CurrentCycleLength);
            _tw.Write(" ");
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