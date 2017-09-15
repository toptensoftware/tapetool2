using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;
using tapetool2.Tape;

namespace tapetool2.Microbee
{
    [Filter("microbee.bytesToBlocks", "Decodes a Microbee byte stream into blocks")]
    class BytesToBlocks : StreamBase, IBlockStream
    {
        public BytesToBlocks()
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

        bool _skipHeader = true;
        public bool SkipHeader
        {
            get { return _skipHeader; }
            set { _skipHeader = value; }
        }

        public override void Rewind()
        {
            base.Rewind();


            if (_skipHeader)
            {
                // Find and skip the header
                CheckedNext();
                while (_input.GetByte() != 0x01)
                {
                    CheckedNext();
                }
            }

            // Read the header
            byte checksum = 16;
            byte[] header = new byte[16];
            for (int i = 0; i < 16; i++)
            {
                CheckedNext();
                header[i] = _input.GetByte();
                checksum += header[i];
            }

            // Read the checksum
            CheckedNext();
            checksum += _input.GetByte();
            if (checksum != 0)
                throw new InvalidDataException(string.Format("Check sum error on tap header (0x{0:x2})", checksum));

            // Store parsed header
            _header = TapeHeader.FromBytes(header);

            // Set the upstream baud rate for correct bit decoding
            var usbr = UpstreamOfType<ISetUpstreamBaudRate>();
            if (usbr != null)
            {
                switch (_header.speed)
                {
                    case 0:
                        usbr.SetUpstreamBaudRate(300);
                        break;
                    case 2:
                        usbr.SetUpstreamBaudRate(600);
                        break;
                    case 0xFF:
                        usbr.SetUpstreamBaudRate(1200);
                        break;
                }
            }

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
            var checksum = (byte)bytesInBlock;

            // Read bytes
            var data = new byte[bytesInBlock];
            for (int i = 0; i < bytesInBlock; i++)
            {
                CheckedNext();
                data[i] = _input.GetByte();
                checksum += data[i];
            }

            // Check the checksum byte
            CheckedNext();

            // Create the block
            var block = new Block();
            block.Address = _blockAddress;
            block.Data = data;
            block.Checksum = _input.GetByte();

            // Check the checksum
            if ((byte)(checksum + block.Checksum) != 0)
                throw new InvalidDataException(string.Format("Checksum error on data block {0:X2}", (byte)(checksum + block.Checksum)));

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

