using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace tapetool2.Microbee
{
    [Filter("microbee.bytesToBits", "Encodes a byte stream into Microbee bit stream")]
    class BytesToBits : StreamBase, IBitStream, IBaudRateProvider
    {
        public BytesToBits()
        {
        }

        IByteStream _source;
        IBaudRateProvider _sourceBRP;

        [Source]
        public IByteStream Source
        {
            get { return _source; }
            set
            {
                _source = value;
                _sourceBRP = UpstreamOfType<IBaudRateProvider>();
            }
        }

        int _currentBaudRate = 300;

        int IBaudRateProvider.BaudRate
        {
            get
            {
                return _currentBaudRate;
            }
        }

        enum State
        {
            bof,
            leadBit,
            dataBits,
            tailBit1,
            tailBit2,
            eof,
        }
        State _state;
        int _bitCounter;

        public override void Rewind()
        {
            base.Rewind();
            _state = State.bof;
        }

        public override IEnumerable<IStream> GetPrecedents()
        {
            yield return _source;
        }

        public bool GetSample()
        {
            switch (_state)
            {
                case State.leadBit:
                    return false;

                case State.dataBits:
                    return ((_source.GetByte() >> _bitCounter) & 0x01)!= 0;

                case State.tailBit1:
                case State.tailBit2:
                    return true;
            }

            throw new InvalidOperationException();
        }

        public override bool Next()
        {
            switch (_state)
            {
                case State.bof:
                    if (!_source.Next())
                        return false;
                    _state = State.leadBit;
                    if (_sourceBRP!=null)
                        _currentBaudRate = _sourceBRP.BaudRate;
                    break;

                case State.leadBit:
                    _bitCounter = 0;
                    _state = State.dataBits;
                    break;

                case State.dataBits:
                    _bitCounter++;
                    if (_bitCounter == 8)
                        _state = State.tailBit1;
                    break;

                case State.tailBit1:
                    _state = State.tailBit2;
                    break;

                case State.tailBit2:
                    if (!_source.Next())
                        return false;
                    if (_sourceBRP != null)
                        _currentBaudRate = _sourceBRP.BaudRate;
                    _state = State.leadBit;
                    break;
            }

            return true;
        }
    }
}
