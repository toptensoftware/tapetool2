using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;
using tapetool2.Tape;

namespace tapetool2.Kansas
{
    [Filter("kansas.bitsToHalfCycleKinds", "Generates Kansas City half-cycle kinds from a bit stream")]
    class BitsToHalfCycleKinds : StreamBase, IHalfCycleKindStream
    {
        public BitsToHalfCycleKinds()
        {
        }

        IBitStream _input;
        IBaudRateProvider _sourceBRP;

        FormatSpec _formatSpec = FormatSpec.KansasCity;
        public void SetFormatSpec(FormatSpec spec)
        {
            _formatSpec = spec;
        }

        [InputStream]
        public IBitStream Input
        {
            get { return _input; }
            set
            {
                _input = value;
                _sourceBRP = UpstreamOfType<IBaudRateProvider>();
            }
        }

        enum State
        {
            leadCycles,     // Before all data
            startBit,
            cycles,
            tailCycles,     // After all data
        }

        State _state;
        int _cyclesLeft;
        HalfCycleKind _halfCycleKind;
        int _baudRate;

        public int LeadHalfCycleCount;
        public int TailHalfCycleCount;
        public HalfCycleKind LeadCycleKind;
        public HalfCycleKind TailCycleKind;

        [FilterOption("baud", "Baud rate to render at")]
        public int BaudRate
        {
            set
            {
                _baudRate = value;
            }
        }

        public override void Rewind()
        {
            base.Rewind();
            _state = LeadHalfCycleCount == 0 ? State.startBit : State.leadCycles;
            _halfCycleKind = LeadCycleKind;
            _cyclesLeft = LeadHalfCycleCount;
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        public int GetCurrentBaudRate()
        {
            return ResolveBaudRate();
        }

        public HalfCycleKind GetHalfCycleKind()
        {
            return _halfCycleKind;
        }

        int ResolveBaudRate()
        {
            if (_baudRate != 0)
                return _baudRate;

            if (_sourceBRP == null)
                return 300;

            return _sourceBRP.BaudRate;
        }

        BaudSpec _activeBaudSpec;
        int _activeBaudRate;
        BaudSpec ResolveBaudSpec()
        {
            int rate = ResolveBaudRate();
            if (rate != _activeBaudRate)
            {
                _activeBaudRate = rate;
                _activeBaudSpec = _formatSpec.GetBaudSpec(rate);
            }
            return _activeBaudSpec;
        }


        protected override bool OnNext()
        {
            switch (_state)
            {
                case State.leadCycles:
                    _cyclesLeft--;
                    if (_cyclesLeft == 0)
                    {
                        _state = State.startBit;
                    }
                    break;

                case State.startBit:
                    // Get the next bit
                    if (!_input.Next())
                    {
                        if (TailHalfCycleCount != 0)
                        {
                            _state = State.tailCycles;
                            _halfCycleKind = TailCycleKind;
                            _cyclesLeft = TailHalfCycleCount;
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                    }
                    bool bit = _input.GetSample();

                    // Get the spec for this bit
                    var spec = ResolveBaudSpec();

                    // Setup for cycles
                    _cyclesLeft = (bit ? spec.OneBitHalfCycleCount : spec.ZeroBitHalfCycleCount) - 1;
                    _halfCycleKind = bit ? spec.OneBitHalfCycleKind : spec.ZeroBitHalfCycleKind;
                    _state = _cyclesLeft > 0 ? State.cycles : State.startBit;
                    break;

                case State.cycles:
                    _cyclesLeft--;
                    if (_cyclesLeft == 0)
                        _state = State.startBit;
                    break;

                case State.tailCycles:
                    if (_cyclesLeft == 0)
                    {
                        return false;
                    }
                    _cyclesLeft--;
                    break;

            }
            return true;
        }
    }
}
