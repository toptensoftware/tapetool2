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

    [Filter("trs80.cycleKindsToBits", "Converts TRS80 cycle kinds into a bit stream")]
    class CycleKindsToBits : StreamBase, IBitStream
    {
        public CycleKindsToBits()
        {
        }

        ICycleKindStream _input;

        [InputStream]
        public ICycleKindStream Input
        {
            get { return _input; }
            set
            {
                _input = value;
            }
        }

        bool _currentBit;
        public override void Rewind()
        {
            base.Rewind();

            // Wait for at least 16 low freq cycles
            if (!NoSync)
            {
                int count = 0;
                while (count < 16)
                {
                    if (!_input.Next())
                        break;      // eof

                    if (_input.GetCycleKind() != CycleKind.Low)
                    {
                        count = 0;
                    }
                    else
                    {
                        count++;
                    }
                }
            }
        }

        [FilterOption("nosync", "Don't wait for lead-in sync")]
        public bool NoSync
        {
            get;
            set;
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        public bool GetSample()
        {
            return _currentBit;
        }

        protected override bool OnNext()
        {
            if (!_input.Next())
                return false;

            switch (_input.GetCycleKind())
            {
                case CycleKind.Low:
                    _currentBit = false;
                    break;

                case CycleKind.High:
                    _currentBit = true;
                    _input.Next();

                    /*  THIS ACTUALLY DOESN'T MATTER
                     *  There's often a small delay after the lead A5 byte in basic program saves
                     *  which doesn't matter.  It just means there's a delay until the next byte
                    if (_input.GetCycleKind() != CycleKind.High)
                    {
                        Console.WriteLine($"Invalid cycle converting cycles to bits, expected {CycleKind.High} after {CycleKind.High} but received {_input.GetCycleKind()} at {((StreamBase)_input).Position}");
                    }*/
                    break;

                case CycleKind.TooLow:
                case CycleKind.Indeterminate:
                    _currentBit = false;
                    Console.WriteLine($"Invalid cycle converting cycles to bits: {_input.GetCycleKind()} at {((StreamBase)_input).Position}");
                    break;

                case CycleKind.TooHigh:
                    _currentBit = true;
                    Console.WriteLine($"Invalid cycle converting cycles to bits: {_input.GetCycleKind()} at {((StreamBase)_input).Position}");
                    _input.Next();
                    break;
            }

            return true;
        }
    }
}     