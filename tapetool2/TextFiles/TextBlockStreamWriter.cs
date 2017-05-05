using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Microbee
{
    [FileWriter("microbee.textBlockStreamWriter", "Text block-stream file writer", "txt", "Text file")]
    class TextBlockStreamWriter : StreamBase, IBlockStream
    {
        public TextBlockStreamWriter()
        {
        }

        [FilterOption("filename", "The file to write", IsFileName = true)]
        public string Filename
        {
            get;
            set;
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

        IBlockStream _input;
        [InputStream]
        public IBlockStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        TextWriter _tw;
        char[] _charBuf;

        public override void Rewind()
        {
            // Base
            base.Rewind();

            Close();

            _tw = new StreamWriter(Filename);
            _tw.WriteLine("[blocks]");
            _charBuf = new char[16];

            // Write the header
            _tw.WriteLine("\n[header]");
            _tw.WriteLine("[");
            _tw.WriteLine("    {0,15}: '{1}'", "filename", _input.Header.filename);
            _tw.WriteLine("    {0,15}: 0x{1:X4} ({1})", "datalen", _input.Header.datalen, _input.Header.datalen);
            _tw.WriteLine("    {0,15}: 0x{1:X4} ({1})", "start address", _input.Header.startaddr, _input.Header.startaddr);
            _tw.WriteLine("    {0,15}: 0x{1:X2} ({1})", "speed", _input.Header.speed, _input.Header.speed);
            _tw.WriteLine("    {0,15}: 0x{1:X2} ({1})", "autostart", _input.Header.autostart, _input.Header.autostart);
            _tw.WriteLine("]");

            _tw.Write("[bytes]     ");
            var headerBytes = _input.Header.ToBytes();
            for (int i=0; i<headerBytes.Length; i++)
            {
                var b = headerBytes[i];
                _tw.Write("{0} ", FormatByte(b));
            }

            _tw.WriteLine();
            _tw.WriteLine("[Checksum]  {0}", FormatByte(_input.Header.Checksum));

        }

    public override IEnumerable<IStream> GetPrecedents()
        {
            yield return Input;
        }

        public TapeHeader Header
        {
            get { return _input.Header; }
        }

        public Block GetBlock()
        {
            return _input.GetBlock();
        }

        public override bool Next()
        {
            if (!_input.Next())
            {
                _tw.WriteLine("\n\n[EOF]");
                return false;
            }

            var block = GetBlock();

            _tw.Write("\n[block:     0x{0:X4}]", block.Address);
            int i;
            for (i=0; i<block.Data.Length; i++)
            {

                if ((i % 16) == 0)
                {
                    if (i > 0 && ascii)
                    {
                        _tw.Write("  ; {0}", new string(_charBuf, 0, _charBuf.Length));
                    }
                    _tw.Write("\n[{0:X8}] ", i);
                }

                var b = block.Data[i];

                _tw.Write(" ");
                _tw.Write(FormatByte(b));

                if (b >= 0x20)
                    _charBuf[i % 16] = (char)b;
                else
                    _charBuf[i % 16] = '.';
            }

            i--;
            if (i > 0 && _ascii)
            {
                _tw.Write(new string(' ', (int)(16 - i% 16 - 1) * 3));
                _tw.Write("  ; {0}", new string(_charBuf, 0, (int)(i % 16) + 1));
            }
            _tw.WriteLine("");
            _tw.WriteLine("[checksum]  {0}", FormatByte(block.Checksum));

            return true;
        }

        string FormatByte(byte b)
        {
            if (_hexPrefix)
                return string.Format("0x{0:X2}", b);
            else
                return string.Format("{0:X2}", b);
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