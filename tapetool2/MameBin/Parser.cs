using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;

namespace tapetool2.MameBin
{
    [Filter("mamebin.parser", "Parses a MAME Z-80 quick load byte stream into a MAME stream")]
    class Parser : StreamBase, IMameStream
    {
        public Parser()
        {

        }

        IByteStream _input;
        MameHeader _header;

        [InputStream]
        public IByteStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        public MameHeader Header => _header;

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
       }

        void CheckedNext()
        {
            if (!_input.Next())
                throw new InvalidOperationException("Unexpected EOF in MAME bin header not found");
        }

        ushort ReadUShort()
        {
            byte lo = _input.GetByte();
            CheckedNext();
            byte hi = _input.GetByte();
            CheckedNext();
            return (ushort)(hi << 8 | lo);
        }

        public override void Rewind()
        {
            base.Rewind();

            // Move to the first byte
            CheckedNext();

            // Skip the first 7 bytes
            for (int i = 0; i < 7; i++)
            {
                CheckedNext();
            }

            // Read the program name
            var prName = new StringBuilder();
            while (true)
            {
                var b = _input.GetByte();

                // End of string
                if (b == 0x1A)
                    break;

                // Ignore nulls?
                if (b != 0x00)
                {
                    // Append program name character
                    prName.Append((char)b, 1);
                }

                // Next character
                CheckedNext();
            }

            // Skip the 0x1A
            CheckedNext();

            // Read the header
            _header.ProgramName = prName.ToString();
            _header.ExecAddress = ReadUShort();
            _header.LoadAddress = ReadUShort();
            _header.LoadLength = (ushort)((ReadUShort() - _header.LoadAddress + 1) & 0xFFFF);
            _dataBytesSent = 0;
            _eofReached = true;
        }

        int _dataBytesSent;
        bool _eofReached;

        public byte GetByte()
        {
            return _input.GetByte();
        }

        public override void WriteSummary(TextWriter w)
        {
            base.WriteSummary(w);
            if (!_eofReached)
            {
                Console.WriteLine("\nWARNING: Extra data found at end of .mame.bin stream, ignored");
            }
        }

        protected override bool OnNext()
        {
            if (_dataBytesSent == _header.LoadLength + 1)
            {
                bool retv = _input.Next();
                _eofReached = !retv;
                return false;
            }

            _dataBytesSent++;

            if (_dataBytesSent > 1)
            {
                bool retv = _input.Next();
                _eofReached = !retv;
                return retv;
            }
            else
                return true;
        }
    }
}
