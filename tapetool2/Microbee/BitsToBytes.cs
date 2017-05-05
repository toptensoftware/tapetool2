using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace tapetool2.Microbee
{
    [Filter("microbee.bitsToBytes", "Decodes a Microbee bit stream into byte stream")]
    class BitsToBytes : StreamBase, IByteStream, ISetUpstreamBaudRate
    {
        public BitsToBytes()
        {
        }

        IBitStream _input;
        byte _currentByte;
        byte[] _leadBytes;
        int _leadByteCount;
        int _leadBytesSent;

        [InputStream]
        public IBitStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        public override void Rewind()
        {
            base.Rewind();

            _leadBytes = new byte[32];
            _leadByteCount = 0;

            while (true)
            {
                // Read the lead byte
                var lb = ScanForByte();
                if (lb == null)
                    return;

                // Store the first byte
                _leadBytes[0] = lb.Value;
                _leadByteCount++;

                // Read some more bytes and check we don't lose sync
                while (_leadByteCount < _leadBytes.Length)
                {
                    var b = TryReadByte();
                    if (b.HasValue)
                    {
                        _leadBytes[_leadByteCount++] = b.Value;
                    }
                }

                // Did we sync?
                if (_leadByteCount == _leadBytes.Length)
                    break;
            }

            TryReadByte();

            _leadBytesSent = -1;
        }

        // Scan for a valid byte pattern and return the byte (or null if pattern not found)
        byte? ScanForByte()
        {
            // Read bits until we get a matching 11xxxxxxxx0 pattern
            uint shiftReg = 0;
            while (_input.Next())
            {
                // Shift in the next bit
                shiftReg = (uint)((_input.GetSample() ? 0x8000u : 0u) | (shiftReg >> 1));
                if ((shiftReg & 0xc000) == 0xc000)
                {
                    // Return the found byte
                    return (byte)((shiftReg >> 6) & 0xFF);
                }
            }
            return null;
        }

        // Parse the next 11 bits into a byte and fail with null if incorrectly formatted
        byte? TryReadByte()
        {
            // Read next 11 bits
            uint shiftReg = 0;
            for (int i=0; i<11; i++)
            {
                if (!_input.Next())
                    return null;

                // Shift in the next bit
                shiftReg = (uint)((_input.GetSample() ? 0x8000u : 0u) | (shiftReg >> 1));
            }

            // Valid?
            if ((shiftReg & 0xc000) == 0xc000)
            {
                // Return the found byte
                return (byte)((shiftReg >> 6) & 0xFF);
            }

            return null;
        }

        // Parse the next 11 bits into a byte and fail with exception if incorrectly formatted
        byte? ReadByte()
        {
            // Read next 11 bits
            uint shiftReg = 0;
            for (int i = 0; i < 11; i++)
            {
                if (!_input.Next())
                {
                    return null;
                }

                // Shift in the next bit
                shiftReg = (uint)((_input.GetSample() ? 0x8000u : 0u) | (shiftReg >> 1));
            }

            // Valid?
            if ((shiftReg & 0xc000) == 0xc000)
            {
                // Return the found byte
                return (byte)((shiftReg >> 6) & 0xFF);
            }

            throw new InvalidDataException("Invalid bit pattern while decoding bytes");
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        public byte GetByte()
        {
            if (_leadBytesSent < _leadByteCount)
                return _leadBytes[_leadBytesSent];
            return _currentByte;
        }

        public override bool Next()
        {
            if (_leadBytesSent < _leadByteCount)
            {
                _leadBytesSent++;
                return true;
            }

            // Read the next byte
            var b = ReadByte();
            if (!b.HasValue)
                return false;       // eof

            _currentByte = b.Value;
            return true;
        }

        void ISetUpstreamBaudRate.SetUpstreamBaudRate(int baudRate)
        {
            // Pass baud rate through to source cycle kind parser
            var upstream = _input as ISetUpstreamBaudRate;
            if (upstream != null)
                upstream.SetUpstreamBaudRate(baudRate);
        }
    }
}

