using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Microbee
{
    [Filter("microbeeTapStreamDecoder", "Decodes a Microbee tap byte stream")]
    class FilterTapStreamDecoder : FilterTapStream
    {
        public FilterTapStreamDecoder()
        {
        }

        FilterByteStream _source;
        TapeHeader _header;
        ushort _blockAddress;
        ushort _bytesLeftInBlock;
        byte _blockCheckSum;

        [Source]
        public FilterByteStream Source
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
            _bytesLeftInBlock = Math.Min(_header.datalen, (ushort)0x100);
            _blockCheckSum = (byte)_bytesLeftInBlock;
        }

        public override TapeHeader Header
        {
            get
            {
                return _header;
            }
        }

        public override byte GetByte()
        {
            return _source.GetByte();
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
            if (_blockAddress >= _header.datalen)
                return false;

            // Move to next byte
            CheckedNext();

            // Update check sum
            _blockCheckSum += _source.GetByte();

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
                _blockCheckSum += _source.GetByte();
            }
            return true;
        }

    }
}
