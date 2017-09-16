using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Binary
{
    [FileWriter("textByteStreamWriter", "Text byte-stream file writer", ".bytes.txt")]
    class TextByteStreamWriter : StreamBase, IByteStream
    {
        public TextByteStreamWriter()
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

        bool _ascii = true;
        [FilterOption("ascii", "Include ASCII character dump (default:true)")]
        public bool ascii
        {
            get { return _ascii; }
            set { _ascii = value; }
        }

        bool _hexPrefix = false;
        [FilterOption("hexPrefix", "Include 0x prefix on each byte")]
        public bool hexPrefix
        {
            get { return _hexPrefix; }
            set { _hexPrefix = value; }
        }

        [FilterOption("raw", "Raw data only")]
        public bool Raw
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

        TextWriter _tw;
        uint _position = 0xFFFFFFFF;
        uint _perLine = 16;
        char[] _charBuf;

        public override void Rewind()
        {
            // Base
            base.Rewind();

            Close();

            _tw = new StreamWriter(Filename);
            if (!Raw)
                _tw.WriteLine("[bytes]");
            _position = 0xFFFFFFFF;
            _charBuf = new char[_perLine];

        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return Input;
        }

        public byte GetByte()
        {
            return _input.GetByte();
        }

        protected override bool OnNext()
        {
            if (!_input.Next())
            {
                if (_position > 0 && _ascii && !Raw)
                {
                    _tw.Write(new string(' ', (int)(_perLine - _position % _perLine - 1) * 3));
                    _tw.Write("  ; {0}", new string(_charBuf, 0, (int)(_position % _perLine) + 1));
                }
                if (!Raw)
                    _tw.WriteLine("\n\n[EOF]");
                return false;
            }

            _position++;

            if ((_position % _perLine) == 0)
            {
                if (_position > 0 && ascii && !Raw)
                {
                    _tw.Write("  ; {0}", new string(_charBuf, 0, _charBuf.Length));
                }
                if (Raw)
                    _tw.Write("\n");
                else
                    _tw.Write("\n[{0:X8}] ", _position);
            }

            var b = _input.GetByte();

            if (_hexPrefix)
                _tw.Write(" 0x{0:X2}", b);
            else
                _tw.Write(" {0:X2}", b);

            if (b >= 0x20)
                _charBuf[_position % _perLine] = (char)b;
            else
                _charBuf[_position % _perLine] = '.';

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