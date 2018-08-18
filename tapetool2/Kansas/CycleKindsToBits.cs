using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;
using tapetool2.Tape;

namespace tapetool2.Kansas
{

    [Filter("kansas.cycleKindsToBits", "Parses Kansas City cycle kinds into a bit stream")]
    class CycleKindsToBits : StreamBase, IBitStream, ISetUpstreamBaudRate
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

        int _upstreamBaudRate = 300;
        int _baudRate;
        bool _currentBit;
        List<CycleKind> _leadCycles;

        [FilterOption("baud", "Baud rate to parse at 0=auto, 300, 600 or 1200")]
        public int BaudRate
        {
            set
            {
                switch (value)
                {
                    case 0:
                    case 300:
                    case 600:
                    case 1200:
                        _baudRate = value;
                        break;

                    default:
                        throw new InvalidOperationException("Invalid baud rate - must be 0 (auto), 300, 600, or 1200");
                }
            }
        }

        int ResolveBaudRate()
        {
            if (_baudRate == 0)
                return _upstreamBaudRate;
            else
                return _baudRate;
        }

        public override void Rewind()
        {
            _upstreamBaudRate = 300;

            base.Rewind();

            _leadCycles = new List<CycleKind>();

            while (true)
            {
                while (_leadCycles.Count < 64)
                {
                    if (!_input.Next())
                    {
                        // Didn't get much but try to sync it anyway
                        while (_leadCycles.Count!=0 && !IsSynced(_leadCycles))
                            _leadCycles.RemoveAt(0);
                        return;
                    }

                    switch (_input.GetCycleKind())
                    {
                        case CycleKind.High:
                        case CycleKind.Low:
                            _leadCycles.Add(_input.GetCycleKind());
                            break;

                        default:
                            _leadCycles.Clear();
                            break;
                    }
                }

                if (IsSynced(_leadCycles))
                {
                    return;
                }

                // Remove the first cycle
                _leadCycles.RemoveAt(0);

                // And try again
                continue;
            }
        }

        int CalcExpectedCycles(CycleKind cycleKind)
        {
            return (cycleKind == CycleKind.High ? 8 : 4) / (ResolveBaudRate() / 300);
        }

        bool IsSynced(List<CycleKind> cycles)
        {
            int i = 0;
            while (i < cycles.Count)
            {
                // How many cycles like this do we expect?
                var expected = CalcExpectedCycles(cycles[i]);

                // Check next expected-1 cycles
                for (int j=1; j< expected; j++)
                {
                    if (i + j >= cycles.Count)
                        return true;

                    if (cycles[i+j] != cycles[i])
                        return false;
                }

                i += expected;
            }

            return true;
        }

        List<CycleKind> FindLeadCycles()
        {
            var leadCycles = new List<CycleKind>();
            while (leadCycles.Count < 64)
            {
                if (!_input.Next())
                    return leadCycles;

                switch (_input.GetCycleKind())
                {
                    case CycleKind.High:
                    case CycleKind.Low:
                        leadCycles.Add(_input.GetCycleKind());
                        break;

                    default:
                        leadCycles.Clear();
                        break;
                }
            }

            return leadCycles;
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        public bool GetSample()
        {
            return _currentBit;
        }

        bool ReadNext(out CycleKind cycleKind)
        {
            // Read the next cycle kind
            if (_leadCycles.Count > 0)
            {
                cycleKind = _leadCycles[0];
                _leadCycles.RemoveAt(0);
            }
            else
            {
                if (!_input.Next())
                {
                    cycleKind = CycleKind.Indeterminate;
                    return false;
                }
                cycleKind = _input.GetCycleKind();
            }
            return true;
        }

        protected override bool OnNext()
        {
            // Get the next cycle kind
            CycleKind cycleKind;
            if (!ReadNext(out cycleKind))
                return false;

            // How many of these cycles should we get?
            int expected = CalcExpectedCycles(cycleKind);

            for (int i=0; i<expected-1; i++)
            {
                CycleKind cycleKind2;
                if (!ReadNext(out cycleKind2))
                    throw new InvalidDataException("Unexpected EOF in middle of bit cycles");
                if (cycleKind2 != cycleKind)
                    throw new InvalidDataException("Mid bit cycle kind mismatch");
            }

            _currentBit = cycleKind == CycleKind.High;
            return true;
        }

        void ISetUpstreamBaudRate.SetUpstreamBaudRate(int baudRate)
        {
            _upstreamBaudRate = baudRate;
        }
    }
}     