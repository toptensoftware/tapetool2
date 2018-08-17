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
    [Filter("sorcerer.blocksToBytes", "Encodes a Exidy Sorcerer block stream into bytes")]
    class BlocksToBytes : StreamBase, IByteStream
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

        protected override bool OnNext()
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
