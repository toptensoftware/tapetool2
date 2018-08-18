using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;
using tapetool2.Tape;

namespace tapetool2.Kansas
{
    [Filter("kansas.bitsToCycleKinds", "Generates Kansas City cycle kinds from a bit stream")]
    class BitsToCycleKinds : StreamBase, ICycleKindStream
    {
        public BitsToCycleKinds()
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
            startBit,
            cycles,
        }

        State _state;
        int _cyclesLeft;
        CycleKind _cycleKind;
        int _baudRate;

        [FilterOption("baud", "Baud rate to render at 0=auto, 300, 600 or 1200")]
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
            _state = State.startBit;
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        public int GetCurrentBaudRate()
        {
            return ResolveBaudRate();
        }

        public CycleKind GetCycleKind()
        {
            return _cycleKind;
        }

        int ResolveBaudRate()
        {
            if (_baudRate != 0)
                return _baudRate;

            if (_sourceBRP == null)
                return 300;

            int rate = _sourceBRP.BaudRate;

            return rate;
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
                case State.startBit:
                    // Get the next bit
                    if (!_input.Next())
                        return false;
                    bool bit = _input.GetSample();

                    // Get the spec for this bit
                    var baudSpec = ResolveBaudSpec();

                    // How many half-cycles for this bit
                    _cyclesLeft = bit ? baudSpec.OneBitHalfCycleCount : baudSpec.ZeroBitHalfCycleCount;
                    // Convert to full cycles
                    if ((_cyclesLeft % 2) != 0)
                        throw new InvalidOperationException("Half-cycles not supported");
                    _cyclesLeft /= 2;
                    _cyclesLeft--;

                    // What kind of cycles?
                    if ((bit ? baudSpec.OneBitHalfCycleKind : baudSpec.ZeroBitHalfCycleKind) == HalfCycleKind.Low)
                        _cycleKind = CycleKind.Low;
                    else
                        _cycleKind = CycleKind.High;

                    // Switch state
                    _state = _cyclesLeft > 0 ? State.cycles : State.startBit;
                    break;

                case State.cycles:
                    _cyclesLeft--;
                    if (_cyclesLeft == 0)
                        _state = State.startBit;
                    break;

            }
            return true;
        }
    }
}
