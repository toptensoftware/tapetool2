using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;
using tapetool2.Tape;

namespace tapetool2.Kansas
{
    [Filter("kansas.bytesToBits", "Encodes a byte stream into Kansas City bit stream")]
    class BytesToBits : StreamBase, IBitStream, IBaudRateProvider
    {
        public BytesToBits()
        {
        }

        IByteStream _input;
        IBaudRateProvider _sourceBRP;

        [InputStream]
        public IByteStream Input
        {
            get { return _input; }
            set
            {
                _input = value;
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

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        public bool GetSample()
        {
            switch (_state)
            {
                case State.leadBit:
                    return false;

                case State.dataBits:
                    return ((_input.GetByte() >> _bitCounter) & 0x01)!= 0;

                case State.tailBit1:
                case State.tailBit2:
                    return true;
            }

            throw new InvalidOperationException();
        }

        protected override bool OnNext()
        {
            switch (_state)
            {
                case State.bof:
                    if (!_input.Next())
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
                    if (!_input.Next())
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
