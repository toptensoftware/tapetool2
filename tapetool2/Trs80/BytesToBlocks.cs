using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;
using tapetool2.Tape;

namespace tapetool2.Trs80
{
    [Filter("trs80.bytesToBlocks", "Decodes a TRS-80 byte stream into blocks")]
    class BytesToBlocks : StreamBase, IBlockStream
    {
        public BytesToBlocks()
        {
        }

        IByteStream _input;

        [InputStream]
        public IByteStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        Header _header;

        public Header Header => _header;

        public bool SkipLeadin = true;

        public override void Rewind()
        {
            base.Rewind();

            // Find the header byte
            if (SkipLeadin)
            {
                while (true)
                {
                    CheckedNext();
                    if (_input.GetByte() == 0xA5)
                        break;
                }
            }

            // Skip the header byte
            CheckedNext();

            _header = new Header();

            var filename = new StringBuilder();
            int filenameLength = 6;
            switch (_input.GetByte())
            {
                case 0x55:
                    _header.FileType = FileType.System;
                    break;

                case 0xD3:
                    CheckedNext();
                    if (_input.GetByte() == 0xD3)
                    {
                        CheckedNext();
                        if (_input.GetByte() != 0xD3)
                        {
                            throw new InvalidOperationException("Invalid header, found 2 0xD3 bytes, expected a third");
                        }
                        _header.FileType = FileType.Basic;
                        filenameLength = 1;
                    }
                    else
                    {
                        // We've already read the first character of the filename
                        _header.FileType = FileType.Text;
                        filename.Append((char)_input.GetByte());
                    }
                    break;

                default:
                    throw new InvalidDataException($"Unrecognized header byte: 0x{_input.GetByte():X2}");
            }

            // Read the rest of the filename
            CheckedNext();
            while (filename.Length < filenameLength)
            {
                filename.Append((char)_input.GetByte());
                CheckedNext();
            }
            _header.FileName = filename.ToString();
        }

        Block _currentBlock;

        public Block CurrentBlock => _currentBlock;

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        List<byte> _captureBytes;

        public void CheckedNext()
        {
            // Capture raw byte blocks?
            if (_captureBytes != null)
                _captureBytes.Add(_input.GetByte());

            if (!_input.Next())
                throw new InvalidDataException("Unexpected EOF in byte stream");
        }

        protected override bool OnNext()
        {
            // Nothing comes after the entry point address block
            if (_currentBlock is EntryPointAddressBlock)
                return false;

            _captureBytes = new List<byte>();

            switch (_header.FileType)
            {
                case FileType.System:
                    if (_input.GetByte() == 0x3C)
                    {
                        _currentBlock = ParseSystemBlock();
                    }
                    else if (_input.GetByte() == 0x78)
                    {
                        _currentBlock = ParseEntryPointBlock();
                    }
                    else
                    {
                        throw new InvalidDataException($"Unexpected byte parsing system data block. Expected 0x3C or 0x78, found 0x{_input.GetByte()} at {((StreamBase)_input).Position}");
                    }
                    break;

                case FileType.Text:
                    if (_input.GetByte() == 0x1A || _input.GetByte() == 0x1B)
                    {
                        _input.Next();
                        _currentBlock = null;
                        return false;
                    }
                    else
                    {
                        _currentBlock = ParseTextBlock();
                        break;
                    }

                case FileType.Basic:
                    {
                        // Parse the line number
                        var addNextLine = (int)_input.GetByte();
                        CheckedNext();
                        addNextLine |= _input.GetByte() << 8;
                        if (addNextLine == 0)
                        {
                            // EOF
                            _input.Next();
                            return false;
                        }
                        CheckedNext();

                        _currentBlock = ParseBasicBlock(addNextLine);
                        break;
                    }

                default:
                    throw new NotImplementedException();
            }

            _currentBlock.PackedBytes = _captureBytes.ToArray();
            _captureBytes = null;

            return true;
        }

        public override void WriteSummary(TextWriter w)
        {
            base.WriteSummary(w);
        }

        Block ParseSystemBlock()
        {
            // Skip 0x3c
            CheckedNext();

            // Read the block length
            byte blockLength = _input.GetByte();
            CheckedNext();

            byte checksum = 0;

            // Read address
            int addr = _input.GetByte();
            checksum += _input.GetByte();
            CheckedNext();
            addr = _input.GetByte() << 8 | addr;
            checksum += _input.GetByte();
            CheckedNext();

            // Read the data
            var bytes = new byte[blockLength == 0 ? 256 : blockLength];
            for (int i=0; i<bytes.Length; i++)
            {
                bytes[i] = _input.GetByte();
                checksum += bytes[i];
                CheckedNext();
            }

            // Read the checksum
            var readChecksum = _input.GetByte();
            CheckedNext();

            // Check the check sum
            if (checksum != readChecksum)
            {
                throw new InvalidDataException($"Check sum error: calculated 0x{checksum} != read 0x{readChecksum} at {((StreamBase)_input).Position} (block address: 0x{addr:X4})");
            }

            return new SystemBlock()
            {
                Address = (ushort)addr,
                Data = bytes,
            };
        }

        Block ParseEntryPointBlock()
        {
            // Skip 0x78
            CheckedNext();

            // Read address
            int addr = _input.GetByte();
            CheckedNext();
            addr = _input.GetByte() << 8 | addr;
            _captureBytes.Add(_input.GetByte());
            _input.Next();

            return new EntryPointAddressBlock()
            {
                EntryPoint = (ushort)addr,
            };
        }

        Block ParseTextBlock()
        {
            // Read the line number
            int lineNumber = 0;
            for (int i = 0; i < 5; i++)
            {
                var ch = _input.GetByte();
                if ((ch & 0x80) == 0)
                {
                    throw new InvalidDataException($"Error in line number header, high bit not set at {((StreamBase)_input).Position}");
                }
                ch = (byte)(ch & ~0x80);

                if (ch < '0' || ch >= '9')
                {
                    throw new InvalidDataException($"Error in line number header, invalid characterat {((StreamBase)_input).Position}");
                }

                lineNumber = lineNumber * 10 + ch - '0';
                CheckedNext();
            }

            // Read the basic line
            var sb = new StringBuilder();
            while (true)
            {
                // EOL?
                if (_input.GetByte() == 0x0D)
                {
                    CheckedNext();
                    break;
                }

                sb.Append((char)_input.GetByte());
                CheckedNext();
            }

            return new TextBlock()
            {
                LineNumber = lineNumber,
                LineText = sb.ToString(),
            };
        }

        Block ParseBasicBlock(int addrNextLine)
        {
            // Read address
            int lineNumber = _input.GetByte();
            CheckedNext();
            lineNumber = _input.GetByte() << 8 | lineNumber;
            CheckedNext();

            // Read the basic line
            var sb = new StringBuilder();
            while (true)
            {
                // EOL?
                if (_input.GetByte() == 0)
                {
                    CheckedNext();
                    break;
                }

                if ((_input.GetByte() & 0x80) != 0)
                {
                    sb.Append(BasicBlock.BasicKeywords[_input.GetByte() & 0x7F]);
                }
                else
                {
                    sb.Append((char)_input.GetByte());
                }
                CheckedNext();
            }

            return new BasicBlock()
            {
                NextLineAddress = (ushort)addrNextLine,
                LineNumber = (ushort)lineNumber,
                LineText = sb.ToString(),
            };
        }

    }
}

