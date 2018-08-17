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
    [Filter("sorcerer.bytesToBlocks", "Decodes a Exidy Sorcerer byte stream into blocks")]
    class BytesToBlocks : StreamBase, IBlockStream
    {
        public BytesToBlocks()
        {
        }

        IByteStream _input;
        TapeHeader _header;
        ushort _blockAddress;
        byte _checksum;

        [InputStream]
        public IByteStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        bool _skipHeader = true;
        public bool SkipHeader
        {
            get { return _skipHeader; }
            set { _skipHeader = value; }
        }

        public byte ReadByte()
        {
            // Move to next byte
            CheckedNext();

            // Read it
            var data = _input.GetByte();

            // Update checksum
            _checksum = (byte)(0xFF - (byte)(data - _checksum));

            // Return it
            return data;
        }


        public override void Rewind()
        {
            base.Rewind();


            if (_skipHeader)
            {
                // Find and skip the header
                while (ReadByte() != 0x01)
                {
                }
            }

            // Read the header
            _checksum = 0;
            byte[] header = new byte[16];
            for (int i = 0; i < 16; i++)
            {
                header[i] = ReadByte();
            }

            // Read the checksum
            var expectedChecksum = _checksum;
            var actualChecksum = ReadByte();
            if (expectedChecksum != actualChecksum)
                throw new InvalidDataException(string.Format("Check sum error on header (calculated 0x{0:X2}, read 0x{1:X2})", expectedChecksum, actualChecksum));

            // Store parsed header
            _header = TapeHeader.FromBytes(header);

            // Wait for leading nulls
            // Find and skip the header
            while (ReadByte() != 0x01)
            {
            }
            _checksum = 0;


            // Start block
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
            {
                _input.Next();      // Trigger eof on input
                return false;
            }

            // How many bytes in this block
            var bytesInBlock = Math.Min((ushort)(_header.datalen - _blockAddress), (ushort)0x100);

            // Read bytes
            _checksum = 0;
            var data = new byte[bytesInBlock];
            for (int i = 0; i < bytesInBlock; i++)
            {
                data[i] = ReadByte();
            }

            var expectedChecksum = _checksum;

            // Create the block
            var block = new Block();
            block.Address = _blockAddress;
            block.Data = data;
            block.Checksum = ReadByte();

            // Check the checksum
            if (block.Checksum != expectedChecksum)
                Console.WriteLine("Check sum error on data block (calculated 0x{0:X2}, read 0x{1:X2})", expectedChecksum, block.Checksum);
                //throw new InvalidDataException(string.Format("Check sum error on data block (calculated 0x{0:X2}, read 0x{1:X2})", expectedChecksum, block.Checksum));

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

