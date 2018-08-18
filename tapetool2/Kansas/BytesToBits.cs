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

        FormatSpec _formatSpec = FormatSpec.KansasCity;
        public void SetFormatSpec(FormatSpec spec)
        {
            _formatSpec = spec;
        }

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
            leadBits,
            dataBits,
            tailBits,
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

        BaudSpec _baudSpec;

        public bool GetSample()
        {
            switch (_state)
            {
                case State.leadBits:
                    return _baudSpec.leadBits[_bitCounter];

                case State.dataBits:
                    return ((_input.GetByte() >> _bitCounter) & 0x01) != 0;

                case State.tailBits:
                    return _baudSpec.tailBits[_bitCounter];
            }

            throw new InvalidOperationException();
        }

        bool StartByte()
        {
            _bitCounter = 0;

            if (!_input.Next())
                return false;

            if (_sourceBRP != null)
                _currentBaudRate = _sourceBRP.BaudRate;

            _baudSpec = _formatSpec.GetBaudSpec(_currentBaudRate);
            _state = _baudSpec.leadBits.Length == 0 ? State.dataBits : State.leadBits;
            return true;
        }

        protected override bool OnNext()
        {
            switch (_state)
            {
                case State.bof:
                    return StartByte();

                case State.leadBits:
                    _bitCounter++;
                    if (_bitCounter == _baudSpec.leadBits.Length)
                    {
                        _bitCounter = 0;
                        _state = State.dataBits;
                    }
                    break;

                case State.dataBits:
                    _bitCounter++;
                    if (_bitCounter == 8)
                    {
                        if (_baudSpec.tailBits.Length > 0)
                        {
                            _bitCounter = 0;
                            _state = State.tailBits;
                        }
                        else
                        {
                            return StartByte();
                        }
                    }
                    break;

                case State.tailBits:
                    _bitCounter++;
                    if (_bitCounter == _baudSpec.tailBits.Length)
                    {
                        return StartByte();
                    }
                    break;
            }

            return true;
        }
    }
}
