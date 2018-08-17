using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;

namespace tapetool2.Sorcerer
{
    [Filter("sorcerer.packData", "Packs binary data into Exidy Sorcerer block format")]
    class PackData: StreamBase, IBlockStream
    {
        public PackData()
        {
        }

        IByteStream _input;
        TapeHeader _header;
        ushort _blockAddress;

        [InputStream]
        public IByteStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        public override void Rewind()
        {
            base.Rewind();

            _input.Rewind();

            if (_header.datalen == 0)
            {
                // Measure input data length
                uint datalen = 0;
                while (_input.Next())
                {
                    datalen++;                
                }

                _input.Rewind();

                if (datalen > 0xFFFF)
                    throw new InvalidOperationException("Input data is too long");

                // Setup header
                _header.filename = "NONAME";
                _header.datalen = (ushort)datalen;
                _header.loadaddr = 0x0400;
                _header.startaddr = 0x0400;
                _header.fileid = (char)0x55;
                _header.filetype = (char)0x00;
            }

            _blockAddress = 0;
        }

        public TapeHeader Header
        {
            get
            {
                return _header;
            }
        }

        Block _currentBlock;

        public Block GetBlock()
        {
            return _currentBlock;
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
            // Clear old block
            _currentBlock = null;

            if (_blockAddress >= _header.datalen)
                return false;

            // How many bytes in this block
            var bytesInBlock = Math.Min((ushort)(_header.datalen - _blockAddress), (ushort)0x100);
            var checksum = (byte)bytesInBlock;

            // Read bytes
            var data = new byte[bytesInBlock];
            for (int i = 0; i < bytesInBlock; i++)
            {
                CheckedNext();
                data[i] = _input.GetByte();
                checksum += data[i];
            }

            // Create the block
            var block = new Block();
            block.Address = _blockAddress;
            block.Data = data;
            block.Checksum = (byte)(0x100 - checksum);

            _currentBlock = block;
            _blockAddress += 0x100;

            return true;
        }

        public override void WriteSummary(TextWriter w)
        {
            base.WriteSummary(w);
            w.WriteLine("    header: {0}", _header);
        }
    }
}

