using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Microbee
{
    [Filter("microbee.blocksToBytes", "Encodes a Microbee block stream into bytes")]
    class BlocksToBytes : StreamBase, IByteStream, IBaudRateProvider
    {
        public BlocksToBytes()
        {
        }

        IBlockStream _input;
        State _state;
        int _stateByteIndex;
        byte[] _headerBytes;

        enum State
        {
            bof,
            leadIn,
            header,
            headerChecksum,
            block,
            blockChecksum,
        }

        [InputStream]
        public IBlockStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        int IBaudRateProvider.BaudRate
        {
            get
            {
                switch (_state)
                {
                    case State.block:
                    case State.blockChecksum:
                        switch (_input.Header.speed)
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

            // Get the header bytes
            _headerBytes = _input.Header.ToBytes();

            // Start before beginning of file
            _state = State.bof;
        }

        public byte GetByte()
        {
            switch (_state)
            {
                case State.leadIn:
                    return (byte)(_stateByteIndex == 63 ? 0x01 : 0x00);

                case State.header:
                    return _headerBytes[_stateByteIndex];

                case State.headerChecksum:
                    return _input.Header.Checksum;

                case State.block:
                    return _input.GetBlock().Data[_stateByteIndex];

                case State.blockChecksum:
                    return _input.GetBlock().Checksum;
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

        public override bool Next()
        {
            switch (_state)
            {
                case State.bof:
                    _state = State.leadIn;
                    _stateByteIndex = 0;
                    return true;

                case State.leadIn:
                    _stateByteIndex++;
                    if (_stateByteIndex == 64)
                    {
                        _state = State.header;
                        _stateByteIndex = 0;
                    }
                    return true;

                case State.header:
                    _stateByteIndex++;
                    if (_stateByteIndex == _headerBytes.Length)
                    {
                        _state = State.headerChecksum;
                    }
                    return true;

                case State.headerChecksum:
                case State.blockChecksum:
                    if (!_input.Next())
                        return false;

                    _stateByteIndex = 0;
                    _state = State.block;
                    return true;

                case State.block:
                    _stateByteIndex++;

                    if (_stateByteIndex == _input.GetBlock().Data.Length)
                    {
                        _state = State.blockChecksum;
                    }

                    return true;
            }
            return false;
        }

    }
}
