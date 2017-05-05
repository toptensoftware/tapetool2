using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace tapetool2.Text
{
    [FileWriter("textBitStreamWriter", "Text bit-stream file writer", "txt", "Text file")]
    class TextBitStreamWriter : StreamBase, IBitStream
    {
        public TextBitStreamWriter()
        {
        }

        [FilterOption("filename", "The file to write", IsFileName = true)]
        public string Filename
        {
            get;
            set;
        }

        IBitStream _input;
        [InputStream]
        public IBitStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        TextWriter _tw;
        uint _position = 0xFFFFFFFF;
        uint _perLine = 32;
        uint _grouping = 0;
        char[] _charBuf;

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

        public override void Rewind()
        {
            // Base
            base.Rewind();

            Close();

            _tw = new StreamWriter(Filename);
            _tw.WriteLine("[bits]");
            _position = 0xFFFFFFFF;
            _charBuf = new char[_perLine];

        }

        public override IEnumerable<IStream> GetPrecedents()
        {
            yield return Input;
        }

        public bool GetSample()
        {
            return _input.GetSample();
        }

        public override bool Next()
        {
            if (!_input.Next())
            {
                _tw.WriteLine("\n\n[EOF]");
                return false;
            }

            _position++;

            if (_grouping!=0 && ((_position % _perLine) % _grouping)==0)
            {
                _tw.Write(" ");
            }

            if ((_position % _perLine) == 0)
            {
                _tw.Write("\n[{0:X8}] ", _position);
            }

            var b = _input.GetSample();

            _tw.Write(b ? '1' : '0');

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