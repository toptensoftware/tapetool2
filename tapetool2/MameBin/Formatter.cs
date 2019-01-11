using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;

namespace tapetool2.MameBin
{
    [Filter("mamebin.formatter", "Formats a MAME stream into a MAME Z-80 quick load byte stream")]
    class Formatter : StreamBase, IByteStream
    {
        public Formatter()
        {

        }

        IMameStream _input;

        [InputStream]
        public IMameStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        void CheckedNext()
        {
            if (!_input.Next())
                throw new InvalidOperationException("Unexpected EOF in MAME bin header not found");
        }

        public override void Rewind()
        {
            base.Rewind();

            // Make the header bytes
            var headerBytes = new List<byte>();
            headerBytes.AddRange(new Byte[] { 0xFD, 0x00, 0x80, 0x00, 0x00 });

            Action<ushort> AddUShort = (x) =>
            {
                headerBytes.Add((byte)(x & 0xFF));
                headerBytes.Add((byte)((x >> 8) & 0xFF));
            };

            // Work out the total length of this file
            var totalLength =
                7                                   // initial header
                + 4                                 // some zeros
                + _input.Header.ProgramName.Length  // Program name
                + 1                                 // The 1A terminator
                + 3 * 2                             // The exec, load addre and load end addr.
                + _input.Header.LoadLength          // The data
                ;
            AddUShort((ushort)(totalLength - 1));

            // Write the leading zeros
            headerBytes.AddRange(new byte[] { 0, 0, 0, 0 });

            // Write the program name
            foreach (var ch in _input.Header.ProgramName)
            {
                if (ch > 1 && ch <= 255)
                    headerBytes.Add((byte)ch);
            }

            // Terminator
            headerBytes.Add(0x1A);

            // Other header data
            AddUShort(_input.Header.ExecAddress);
            AddUShort(_input.Header.LoadAddress);
            AddUShort((ushort)(_input.Header.LoadAddress + _input.Header.LoadLength - 1));

            // Sanity check
            System.Diagnostics.Debug.Assert(headerBytes.Count + _input.Header.LoadLength == totalLength);
            _headerBytes = headerBytes.ToArray();
            _headerPos = -1;
            _dataPos = -1;
        }

        byte[] _headerBytes;
        int _headerPos;
        int _dataPos;

        public byte GetByte()
        {
            if (_headerPos < _headerBytes.Length)
                return _headerBytes[_headerPos];
            else
                return _input.GetByte();
        }

        protected override bool OnNext()
        {
            if (_headerPos < _headerBytes.Length)
            {
                _headerPos++;
                if (_headerPos < _headerBytes.Length)
                    return true;
            }

            // Move to next data byte
            _dataPos++;
            bool ok = _input.Next();

            if (_dataPos == _input.Header.LoadLength)
            {
                return false;
            }

            // Check expected data length matches
            if (!ok)
                throw new InvalidOperationException("MAME stream returned less data than header indicated");

            return ok;
        }
    }
}
