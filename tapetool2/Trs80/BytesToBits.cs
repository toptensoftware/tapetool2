using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;
using tapetool2.Tape;

namespace tapetool2.Trs80
{
    [Filter("trs80.bytesToBits", "Encodes a byte stream into TRS-80 bit stream")]
    class BytesToBits : StreamBase, IBitStream
    {
        public BytesToBits()
        {
        }

        IByteStream _input;

        [InputStream]
        public IByteStream Input
        {
            get { return _input; }
            set
            {
                _input = value;
            }
        }

        int _bitCounter;
        byte _byte;

        public override void Rewind()
        {
            base.Rewind();
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        public bool GetSample()
        {
            return (_byte & 0x80) != 0;
        }

        protected override bool OnNext()
        {
            if (_bitCounter == 0)
            {
                if (!_input.Next())
                    return false;

                _byte = _input.GetByte();
                _bitCounter = 7;
                return true;
            }
            else
            {
                _bitCounter--;
                _byte <<= 1;
                return true;
            }
        }
    }
}
