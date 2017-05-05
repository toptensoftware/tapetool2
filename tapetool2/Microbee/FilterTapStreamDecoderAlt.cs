using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;


/*
namespace tapetool2.Microbee
{
    [Filter("microbeeTapStreamDecoder", "Decodes a Microbee tap byte stream")]
    class FilterTapStreamDecoder : ITapStream
    {
        public FilterTapStreamDecoder()
        {
        }

        IByteStream _source;
        TapeHeader _header;
        ushort _blockAddress;

        [Source]
        public IByteStream Source
        {
            get { return _source; }
            set { _source = value; }
        }

        public override void Rewind()
        {
            base.Rewind();

            // Find the header
            CheckedNext();
            while (_source.GetByte() != 0x01)
            {
                CheckedNext();
            }

            // Read the header
            byte checksum = 16;
            byte[] header = new byte[16];
            for (int i = 0; i < 16; i++)
            {
                CheckedNext();
                header[i] = _source.GetByte();
                checksum += header[i];
            }

            // Read the checksum
            CheckedNext();
            checksum += _source.GetByte();
            if (checksum != 0)
                throw new InvalidDataException(string.Format("Check sum error on tap header (0x{0:x2})", checksum));

            // Store parsed header
            _header = TapeHeader.FromBytes(header);

            // Start block
            _blockAddress = 0;
        }

        public override TapeHeader Header
        {
            get
            {
                return _header;
            }
        }

        Block _currentBlock;

        public override Block GetBlock()
        {
            return _currentBlock;
        }

        public override IEnumerable<IStream> GetPrecedents()
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
            // Clear old block
            _currentBlock = null;

            if (_blockAddress >= _header.datalen)
                return false;

            // How many bytes in this block
            var bytesInBlock = Math.Min((ushort)(_header.datalen - _blockAddress), (ushort)0x100);
            var checksum = (byte)_bytesLeftInBlock;

            // Read bytes
            var data = new byte[bytesInBlock];
            for (int i = 0; i < bytesInBlock; i++)
            {
                CheckedNext();
                data[i] = _source.GetByte();
                checksum += data[i];
            }

            // Check the checksum byte
            CheckedNext();

            // Create the block
            var block = new Block();
            block.Address = _blockAddress;
            block.Data = data;
            block.Checksum = _source.GetByte();

            // Check the checksum
            if ((byte)(checksum + block.Checksum) != 0)
                throw new InvalidDataException("Checksum error on data block");

            _currentBlock = block;
            _blockAddress += 0x100;
        }

    }
}


using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Microbee
{
    [StreamKind("Microbee tap stream", "Microbee tap stream")]
    abstract class ITapStream : Filter
    {
        public abstract TapeHeader Header
        {
            get;
        }

        public abstract Block GetBlock();

        public class Block
        {
            public ushort Address;
            public byte[] Data;
            public byte Checksum;
        }
    }
}
*/