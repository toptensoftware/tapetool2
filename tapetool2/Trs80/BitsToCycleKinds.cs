using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;
using tapetool2.Tape;

namespace tapetool2.Trs80
{
    [Filter("trs80.bitsToCycleKinds", "Generates TRS-80 cycle kinds from a bit stream")]
    class BitsToCycleKinds : StreamBase, ICycleKindStream
    {
        public BitsToCycleKinds()
        {
        }

        IBitStream _input;

        [InputStream]
        public IBitStream Input
        {
            get { return _input; }
            set
            {
                _input = value;
            }
        }

        int _cyclesLeft;
        CycleKind _cycleKind;

        public override void Rewind()
        {
            base.Rewind();
            _cyclesLeft = 0;
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        public CycleKind GetCycleKind()
        {
            return _cycleKind;
        }

        public int GetCurrentBaudRate()
        {
            // NA
            return 0;
        }

        protected override bool OnNext()
        {
            // Any more cycles in this bit?
            if (_cyclesLeft != 0)
            {
                _cyclesLeft--;
                return true;
            }

            // Get the next bit
            if (!_input.Next())
                return false;
            bool bit = _input.GetSample();

            // Setup cycles
            if (bit)
            {
                _cycleKind = CycleKind.High;
                _cyclesLeft = 1;
            }
            else
            {
                _cycleKind = CycleKind.Low;
                _cyclesLeft = 0;
            }

            return true;
        }
    }
}
