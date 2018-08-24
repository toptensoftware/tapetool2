using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;
using tapetool2.Tape;

namespace tapetool2.Trs80
{
    [Filter("trs80.bitsToBytes", "Decodes a TRS-80 bit stream into byte stream")]
    class BitsToBytes : StreamBase, IByteStream
    {
        public BitsToBytes()
        {
        }

        IBitStream _input;
        byte _currentByte;
        int _leadingZeroCount;
        bool _leadByteSent;
        bool _leadByteFound;

        [InputStream]
        public IBitStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        public override void Rewind()
        {
            base.Rewind();

            // Look for the lead byte
            _leadByteFound = false;
            _currentByte = 0xFF;
            int skippedZeroBits = 0;
            while (true)
            {
                // Read next bit
                if (!_input.Next())
                    return;

                // Count how many zero bits we skipped
                if ((_currentByte & 0x80) == 0)
                    skippedZeroBits++;
                else
                    skippedZeroBits = 0;

                // Update the current byte
                _currentByte = (byte)(_currentByte << 1 | (_input.GetSample() ? 0x01 : 0x00));

                // Is it the lead byte
                if (_currentByte == 0xA5)
                {
                    _leadByteFound = true;
                    break;
                }
            }

            // How many leading zeros were there?
            _leadingZeroCount = skippedZeroBits / 8;
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        public byte GetByte()
        {
            return _currentByte;
        }

        protected override bool OnNext()
        {
            // Did we find the lead byte
            if (!_leadByteFound)
                return false;

            // Have we sent all the leading zeroes?
            if (_leadingZeroCount > 0)
            {
                _leadingZeroCount--;
                _currentByte = 0;
                return true;
            }

            // Has the lead 0xA5 byte been sent?
            if (!_leadByteSent)
            {
                _leadByteSent = true;
                _currentByte = 0xA5;
                return true;
            }

            // Read next 8 bits for the next byte
            _currentByte = 0;
            for (int i = 0; i < 8; i++)
            {
                if (!_input.Next())
                {
                    return false;
                }

                _currentByte = (byte)(_currentByte << 1 | (_input.GetSample() ? 0x01 : 0x00));
            }

            return true;
        }

    }
}

