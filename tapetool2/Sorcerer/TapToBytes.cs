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
    [Filter("sorcerer.tapToBytes", "Decodes a Exidy Sorcerer tap byte stream")]
    class TapToBytes : StreamBase, ITapStream
    {
        public TapToBytes()
        {
        }

        IByteStream _input;
        TapeHeader _header;
        ushort _blockAddress;
        ushort _bytesLeftInBlock;
        byte _blockCheckSum;

        [InputStream]
        public IByteStream Input
        {
            get { return Input1; }
            set { Input1 = value; }
        }

        public override void Rewind()
        {
            base.Rewind();

            // Find the header
            CheckedNext();
            while (Input1.GetByte() != 0x01)
            {
                CheckedNext();
            }

            // Read the header
            byte checksum = 16;
            byte[] header = new byte[16];
            for (int i = 0; i < 16; i++)
            {
                CheckedNext();
                header[i] = Input1.GetByte();
                checksum += header[i];
            }

            // Read the checksum
            CheckedNext();
            checksum += Input1.GetByte();
            if (checksum != 0)
                throw new InvalidDataException(string.Format("Check sum error on tap header (0x{0:x2})", checksum));

            // Store parsed header
            _header = TapeHeader.FromBytes(header);

            // Start block
            _blockAddress = 0;
            _bytesLeftInBlock = Math.Min(_header.datalen, (ushort)0x100);
            _blockCheckSum = (byte)_bytesLeftInBlock;
        }

        public TapeHeader Header
        {
            get
            {
                return _header;
            }
        }

        internal IByteStream Input1
        {
            get
            {
                return _input;
            }

            set
            {
                _input = value;
            }
        }

        public byte GetByte()
        {
            return Input1.GetByte();
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return Input1;
        }

        public void CheckedNext()
        {
            if (!Input1.Next())
                throw new InvalidDataException("Unexpected EOF in tap stream");
        }

        protected override bool OnNext()
        {
            if (_blockAddress >= _header.datalen)
                return false;

            // Move to next byte
            CheckedNext();

            // Update check sum
            _blockCheckSum += Input1.GetByte();

            if (_bytesLeftInBlock > 0)
            {
                // Update counter
                _bytesLeftInBlock--;
                return true;
            }

            // Check check sum
            if (_blockCheckSum != 0)
                throw new InvalidDataException(string.Format("Check sum error on data block (0x{0:x2})", _blockCheckSum));

            // Start next block
            _blockAddress += 0x100;
            if (_blockAddress >= _header.datalen)
                return false;
            _bytesLeftInBlock = Math.Min((ushort)(_header.datalen - _blockAddress), (ushort)0x100);
            _blockCheckSum = (byte)_bytesLeftInBlock;

            if (_bytesLeftInBlock>0)
            {
                _bytesLeftInBlock--;
                CheckedNext();
                _blockCheckSum += Input1.GetByte();
            }
            return true;
        }

    }
}
