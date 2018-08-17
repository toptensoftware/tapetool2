using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;
using tapetool2.Tape;

namespace tapetool2.Sorcerer
{
    [Filter("sorcerer.bytesToTap", "Encodes a byte stream into a Exidy Sorcerer tap stream")]
    class BytesToTap : StreamBase, IByteStream
    {
        public BytesToTap()
        {
        }

        IByteStream _input;
        TapeHeader _header;
        State _state;
        int _stateByteCount;
        int _stateByteIndex;
        byte _byteSum;
        byte[] _headerBytes;
        uint _blockAddress;

        enum State
        {
            bof,
            leadIn,
            header,
            headerChecksum,
            block,
            blockChecksum,
        }

        // These properties override the values from source tap stream
        string _filename;
        char? _fileid;
        char? _filetype;
        ushort? _datalen;
        ushort? _loadaddr;
        ushort? _startaddr;
        byte? _speed;
        byte? _autostart;

        [FilterOption("filename", "Sets or overrides the header filename")]
        public string Filename
        {
            set { _filename = value; }
        }

        [FilterOption("fileId", "Sets or overrides the header file id")]
        public char FileHeaderId
        {
            set { _fileid = value; }
        }

        [FilterOption("fileType", "Sets or overrides the header file type")]
        public char FileType
        {
            set { _filetype = value; }
        }

        [FilterOption("dataLen", "Sets or overrides the header data length")]
        public ushort DataLen
        {
            set { _datalen = value; }
        }

        [FilterOption("loadAddr", "Sets or overrides the header load address")]
        public ushort LoadAddress
        {
            set { _loadaddr = value; }
        }

        [FilterOption("startAddr", "Sets or overrides the header start address")]
        public ushort StartAddress
        {
            set { _startaddr = value; }
        }

        [FilterOption("speed", "Sets or overrides the header speed field")]
        public byte Speed
        {
            set { _speed = value; }
        }

        [FilterOption("autoStart", "Sets or overrides the header auto-start field")]
        public byte AutoStart
        {
            set { _autostart = value; }
        }

        [InputStream]
        public IByteStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        public override void Rewind()
        {
            base.Rewind();

            _header.filename = "NONME";
            _header.fileid = (char)0x55;
            _header.filetype = '\0';
            _header.datalen = 0;
            _header.loadaddr = 0;
            _header.startaddr = 0;

            // If source is a tap stream, use it's header
            var upstream = UpstreamOfType<ITapStream>();
            if (upstream!=null)
            {
                _header = upstream.Header;
            }

            // Resolve the header
            if (_filename != null)
                _header.filename = _filename;
            if (_fileid.HasValue)
                _header.fileid = _fileid.Value;
            if (_filetype.HasValue)
                _header.filetype = _filetype.Value;
            if (_datalen.HasValue)
                _header.datalen = _datalen.Value;
            if (_loadaddr.HasValue)
                _header.loadaddr = _loadaddr.Value;
            if (_startaddr.HasValue)
                _header.startaddr = _startaddr.Value;

            // Work out how long data is
            if (_header.datalen == 0)
            {
                _input.Rewind();
                while (_input.Next())
                {
                    _header.datalen++;
                }
                _input.Rewind();
            }

            // Get the header bytes
            _headerBytes = _header.ToBytes();

            // Start before beginning of file
            _state = State.bof;
        }

        public byte GetByte()
        {
            switch (_state)
            {
                case State.leadIn:
                    return (byte)(_stateByteIndex + 1 == _stateByteCount ? 0x01 : 0x00);

                case State.header:
                    return _headerBytes[_stateByteIndex];

                case State.block:
                    return _input.GetByte();

                case State.headerChecksum:
                case State.blockChecksum:
                    return (byte)(0x100 - _byteSum);

            }

            throw new InvalidOperationException();
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        public void CheckedNext()
        {
            if (!_input.Next())
                throw new InvalidDataException("Unexpected EOF in tap stream");
        }

        protected override bool OnNext()
        {
            switch (_state)
            {
                case State.bof:
                    _state = State.leadIn;
                    _stateByteCount = 64;
                    _stateByteIndex = 0;
                    return true;

                case State.leadIn:
                    _stateByteIndex++;
                    if (_stateByteIndex == _stateByteCount)
                    {
                        _state = State.header;
                        _stateByteCount = _headerBytes.Length;
                        _stateByteIndex = 0;
                        _byteSum = (byte)_stateByteCount;
                    }
                    return true;

                case State.header:
                    _byteSum += GetByte();
                    _stateByteIndex++;
                    if (_stateByteIndex == _stateByteCount)
                    {
                        _state = State.headerChecksum;
                        _blockAddress = 0;
                    }
                    return true;

                case State.headerChecksum:
                case State.blockChecksum:
                    // EOF?
                    if (_blockAddress > _header.datalen)
                    {
                        _input.Next();     // Not necessary but lets text writers flush eof tag 
                        return false;
                    }

                    // Get the next byte
                    CheckedNext();

                    _stateByteCount = (ushort)(Math.Min(_header.datalen - _blockAddress, 0x100));
                    _stateByteIndex = 0;
                    _byteSum = (byte)(_stateByteCount & 0xFF);
                    _state = State.block;
                    return true;

                case State.block:
                    _byteSum += GetByte();
                    _stateByteIndex++;

                    if (_stateByteIndex == _stateByteCount)
                    {
                        _state = State.blockChecksum;
                        _blockAddress += 0x100;
                    }
                    else
                    {
                        CheckedNext();
                    }
                    return true;
            }
            return false;
        }

    }
}
