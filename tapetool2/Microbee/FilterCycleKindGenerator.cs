using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Microbee
{
    interface IBaudRateProvider
    {
        int BaudRate { get; }
    }

    [Filter("microbeeCycleKindGenerator", "Generates Microbee cycle kinds from a bit stream")]
    class FilterCycleKindGenerator : FilterCycleKindStream
    {
        public FilterCycleKindGenerator()
        {
        }

        FilterBitStream _source;
        IBaudRateProvider _sourceBRP;

        [Source]
        public FilterBitStream Source
        {
            get { return _source; }
            set
            {
                _source = value;
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

        [FilterOption("baudRate", "Baud rate to render at 0=auto, 300, 600 or 1200")]
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

        public override void Rewind()
        {
            base.Rewind();
            _state = State.startBit;
        }

        public override IEnumerable<Filter> GetPrecedents()
        {
            yield return _source;
        }

        public override CycleKind GetCycleKind()
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

            if (rate == 1200)
            {
                int x = 3;
            }

            return rate;
        }

        public override bool Next()
        {
            switch (_state)
            {
                case State.startBit:
                    if (!_source.Next())
                        return false;

                    _cyclesLeft = (_source.GetSample() ? 8 : 4) / (ResolveBaudRate()/ 300) - 1;
                    _state = _cyclesLeft > 0 ? State.cycles : State.startBit;
                    _cycleKind = _source.GetSample() ? CycleKind.High : CycleKind.Low;
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
