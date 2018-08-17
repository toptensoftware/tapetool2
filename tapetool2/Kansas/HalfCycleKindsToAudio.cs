using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Audio;
using tapetool2.Tape;

namespace tapetool2.Kansas
{
    [Filter("kansas.halfCycleKindsToAudio", "Generates Kansas City audio from a half-cycle kind stream")]
    class HalfCycleKindsToAudio : StreamBase, IAudioStream
    {
        public HalfCycleKindsToAudio()
        {
        }

        FormatSpec _formatSpec = FormatSpec.KansasCity;
        public void SetFormatSpec(FormatSpec spec)
        {
            _formatSpec = spec;
        }

        IHalfCycleKindStream _input;
    
        [InputStream]
        public IHalfCycleKindStream Input
        {
            get { return _input; }
            set
            {
                _input = value;
            }
        }

        int _sampleRate = 22050;
        float _volume = 0.75f;

        [FilterOption("sampleRate", "sample rate at which to render")]
        public int SampleRateOption
        {
            set
            {
                _sampleRate = value;
            }
        }

        [FilterOption("volume", "volume which to render (default=0.75)")]
        public float Volume
        {
            set
            {
                _volume = value;
            }
        }

        public int SampleRate
        {
            get
            {
                return _sampleRate;
            }
        }

        public int ChannelCount
        {
            get
            {
                return 1;
            }
        }


        public int BitsPerSample
        {
            get
            {
                return 8;
            }
        }

        uint _currentSampleNumber;      // in samples
        double _currentCycleTime;       // in seconds
        bool _currentSample;

        public override void Rewind()
        {
            base.Rewind();
            _currentSampleNumber = 0xFFFFFFFF;
            _currentSample = false;
            _baudSpec = _formatSpec.GetBaudSpec(_baudRate);
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        BaudSpec _baudSpec;
        int _baudRate = 300;
        [FilterOption("baudRate", "baud rate (default=300)")]
        public int baudRate
        {
            set
            {
                _baudRate = value;
            }
        }

        double highCycleTime => (1.0 / (_baudSpec.LowFrequency * 2)) / 2;
        double lowCycleTime => (1.0 / _baudSpec.LowFrequency) / 2;

        public float GetSample(int channel)
        {
            return _currentSample ? _volume : -_volume;
        }

        protected override bool OnNext()
        {
            // Update the current sample number
            _currentSampleNumber++;

            // First call?
            if (_currentSampleNumber == 0)
            {
                // Reset cycle time counter
                _currentCycleTime = 0;
                _currentSample = true;

                // Read the first cycle kind
                return _input.Next();
            }

            double currentTime = (double)_currentSampleNumber / _sampleRate;
            double currentTimeInCycle = currentTime - _currentCycleTime;
            double currentCycleLength = _input.GetHalfCycleKind() == HalfCycleKind.High ? highCycleTime : lowCycleTime;

            if (currentTimeInCycle >= currentCycleLength)
            {
                // Get the next cycle kind
                if (!_input.Next())
                    return false;

                _currentCycleTime += currentCycleLength;
                currentTimeInCycle = currentTime - _currentCycleTime;
                currentCycleLength = _input.GetHalfCycleKind() == HalfCycleKind.High ? highCycleTime : lowCycleTime;

                // Toggle
                _currentSample = !_currentSample;
            }

            return true;
        }
    }
}
