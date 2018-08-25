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
    [Filter("trs80.blocksToBytes", "Encodes a TRS-80 block stream into bytes")]
    class BlocksToBytes : StreamBase, IByteStream
    {
        public BlocksToBytes()
        {
        }

        IBlockStream _input;
        byte[] _bytes;
        int _byteIndex;
        bool _inTailBlock;

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
            var header = new List<byte>();

            // Add the leadin
            header.AddRange(Enumerable.Repeat<byte>(0, 255));

            // Add the sync byte
            header.Add(0xA5);

            // Add the header bytes
            header.AddRange(_input.Header.Bytes);

            // Build array
            _bytes = header.ToArray();
            _byteIndex = -1;
            _inTailBlock = false;
        }

        public byte GetByte()
        {
            return _bytes[_byteIndex];
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        protected override bool OnNext()
        {
            // More in current block?
            if (_byteIndex + 1 < _bytes.Length)
            {
                _byteIndex++;
                return true;
            }

            if (_inTailBlock)
                return false;

            // Get the next block
            if (!_input.Next())
            {
                _inTailBlock = true;
                switch (_input.Header.FileType)
                {
                    case FileType.Basic:
                        _bytes = new byte[] { 0, 0 };
                        _byteIndex = 0;
                        return true;

                    case FileType.Text:
                        _bytes = new byte[] { 0x1b };
                        _byteIndex = 0;
                        return true;
                }
                return false;
            }

            // Setup for the next block
            _byteIndex = 0;
            _bytes = _input.CurrentBlock.PackedBytes;
            return true;
        }

    }
}
