using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Microbee
{
    [Filter("microbeeTapStreamEncoder", "Encodes a byte stream into a Microbee tap stream")]
    class FilterTapStreamEncoder : FilterByteStream, IBaudRateProvider
    {
        public FilterTapStreamEncoder()
        {
        }

        FilterByteStream _source;
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
            checksum,
            block,
        }

        // These properties override the values from source tap stream
        string _filename;
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

        [Source]
        public FilterByteStream Source
        {
            get { return _source; }
            set { _source = value; }
        }

        int IBaudRateProvider.BaudRate
        {
            get
            {
                switch (_state)
                {
                    case State.block:
                        switch (_header.speed)
                        {
                            default:
                                return 300;
                            case 0xFF:
                                return 1200;
                            case 0x02:
                                return 600;
                        }

                    default:
                        return 300;
                }
            }
        }

        public override void Rewind()
        {
            base.Rewind();

            _header.filename = "NONAME";
            _header.filetype = '\0';
            _header.datalen = 0;
            _header.loadaddr = 0;
            _header.startaddr = 0;
            _header.speed = 0;
            _header.autostart = 0;

            // If source is a tap stream, use it's header
            var upstream = UpstreamOfType<FilterTapStream>();
            if (upstream!=null)
            {
                _header = upstream.Header;
            }

            // Resolve the header
            if (_filename != null)
                _header.filename = _filename;
            if (_filetype.HasValue)
                _header.filetype = _filetype.Value;
            if (_datalen.HasValue)
                _header.datalen = _datalen.Value;
            if (_loadaddr.HasValue)
                _header.loadaddr = _loadaddr.Value;
            if (_startaddr.HasValue)
                _header.startaddr = _startaddr.Value;
            if (_speed.HasValue)
                _header.speed = _speed.Value;
            if (_autostart.HasValue)
                _header.autostart = _autostart.Value;

            // Work out how long data is
            if (_header.datalen == 0)
            {
                _source.Rewind();
                while (_source.Next())
                {
                    _header.datalen++;
                }
                _source.Rewind();
            }

            // Get the header bytes
            _headerBytes = _header.ToBytes();

            // Start before beginning of file
            _state = State.bof;
        }

        public override byte GetByte()
        {
            switch (_state)
            {
                case State.leadIn:
                    return (byte)(_stateByteIndex + 1 == _stateByteCount ? 0x01 : 0x00);

                case State.header:
                    return _headerBytes[_stateByteIndex];

                case State.block:
                    return _source.GetByte();

                case State.checksum:
                    return (byte)(0x100 - _byteSum);

            }

            throw new InvalidOperationException();
        }

        public override IEnumerable<Filter> GetPrecedents()
        {
            yield return _source;
        }

        public void CheckedNext()
        {
            if (!_source.Next())
                throw new InvalidDataException("Unexpected EOF in tap stream");
        }

        public override bool Next()
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
                        _state = State.checksum;
                        _blockAddress = 0;
                    }
                    return true;

                case State.checksum:
                    // EOF?
                    if (_blockAddress > _header.datalen)
                    {
                        _source.Next();     // Not necessary but lets text writers flush eof tag 
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
                        _state = State.checksum;
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
