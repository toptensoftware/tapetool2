using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Microbee
{
    [Filter("microbee.unpackData", "Unpacks binary data from Microbee block format")]
    class UnpackData : StreamBase, IByteStream
    {
        public UnpackData()
        {
        }

        IBlockStream _input;
        State _state;
        int _stateByteIndex;
        byte[] _headerBytes;

        enum State
        {
            bof,
            block,
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
            return _input.GetBlock().Data[_stateByteIndex];
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
                    _stateByteIndex = 0;
                    if (!_input.Next())
                        return false;
                    _state = State.block;
                    return true;

                case State.block:
                    _stateByteIndex++;

                    if (_stateByteIndex == _input.GetBlock().Data.Length)
                    {
                        _stateByteIndex = 0;
                        if (!_input.Next())
                            return false;
                    }

                    return true;
            }
            return false;
        }

    }
}
