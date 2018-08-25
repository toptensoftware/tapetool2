using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Trs80
{
    [FileWriter("trs80.textBlockStreamWriter", "Text block-stream file writer", ".blocks.txt")]
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

            // File type
            var header = _input.Header;
            _tw.WriteLine($"\n[filetype: {header.FileType}]");
            var ftBytes = header.FileTypeBytes;
            for (int i = 0; i < ftBytes.Length; i++)
            {
                var b = ftBytes[i];
                _tw.Write("{0} ", FormatByte(b));
            }

            // File name
            _tw.WriteLine($"\n\n[filename: '{header.FileName}']");
            ftBytes = header.FileNameBytes;
            for (int i = 0; i < ftBytes.Length; i++)
            {
                var b = ftBytes[i];
                _tw.Write("{0} ", FormatByte(b));
            }
            _tw.WriteLine();
            _tw.WriteLine();
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return Input;
        }

        public Header Header => _input.Header;


        public Block CurrentBlock => _input.CurrentBlock;

        protected override bool OnNext()
        {
            if (!_input.Next())
            {
                switch (_input.Header.FileType)
                {
                    case FileType.Text:
                        _tw.WriteLine($"[EOF] {FormatByte(0x1b)}");
                        break;

                    case FileType.Basic:
                        _tw.WriteLine($"[EOF] {FormatWord(0)}");
                        break;

                    default:
                        _tw.WriteLine("\n\n[EOF]");
                        break;
                }

                return false;
            }

            var block = CurrentBlock;

            if (block is SystemBlock)
            {
                DumpSystemBlock((SystemBlock)block);
            }
            else if (block is EntryPointAddressBlock)
            {
                DumpEntryPointBlock((EntryPointAddressBlock)block);
            }
            else if (block is TextBlock)
            {
                DumpTextBlock((TextBlock)block);
            }
            else if (block is BasicBlock)
            {
                DumpBasicBlock((BasicBlock)block);
            }

            return true;
        }

        void DumpBytes(byte[] bytes)
        {
            int i;
            for (i = 0; i < bytes.Length; i++)
            {

                if ((i % 16) == 0)
                {
                    if (i > 0 && ascii)
                    {
                        _tw.Write("  ; {0}", new string(_charBuf, 0, _charBuf.Length));
                    }
                    _tw.Write("\n[{0:X8}] ", i);
                }

                var b = bytes[i];

                _tw.Write(" ");
                _tw.Write(FormatByte(b));

                if (b >= 0x20 && b < 0x7F)
                    _charBuf[i % 16] = (char)b;
                else
                    _charBuf[i % 16] = '.';
            }

            i--;
            if (i > 0 && _ascii)
            {
                _tw.Write(new string(' ', (int)(16 - i % 16 - 1) * 3));
                _tw.Write("  ; {0}", new string(_charBuf, 0, (int)(i % 16) + 1));
            }
            _tw.WriteLine("");
        }

        void DumpSystemBlock(SystemBlock block)
        {
            _tw.WriteLine("\n[block: Load Addr:0x{0:X4}]", block.Address);
            _tw.WriteLine($"[header  ] {FormatByte(0x3c)}");
            _tw.WriteLine($"[length  ] {FormatByte((byte)(block.Data.Length == 0x100 ? 0 : block.Data.Length))}");
            _tw.Write($"[loadAddr] {FormatWord(block.Address)}");
            DumpBytes(block.Data);
            _tw.WriteLine("[checksum]  {0}", FormatByte(block.Checksum));
        }

        void DumpEntryPointBlock(EntryPointAddressBlock block)
        {
            _tw.WriteLine("\n[entry point:0x{0:X4}]", block.EntryPoint);
            _tw.WriteLine($"[header  ] {FormatByte(0x78)}");
            _tw.WriteLine($"[loadAddr] {FormatWord(block.EntryPoint)}");
        }

        void DumpTextBlock(TextBlock block)
        {
            _tw.Write($"[{block.LineNumber,5}{block.LineText}]");
            DumpBytes(block.PackedBytes);
            _tw.WriteLine();
        }


        void DumpBasicBlock(BasicBlock block)
        {
            _tw.Write($"[next: 0x{block.NextLineAddress:X4}]");
            _tw.Write($"[{block.LineNumber,5} {block.LineText}]");
            DumpBytes(block.PackedBytes);
            _tw.WriteLine();
        }

        string FormatWord(ushort w)
        {
            return $"{FormatByte((byte)(w & 0xFF))} {FormatByte((byte)((w >> 8) & 0xFF))}";
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