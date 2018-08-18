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

        public enum WaveShape
        {
            square,
            sine,
        }

        [FilterOption("waveShape", "shape of generated waves (square, sine)")]
        public WaveShape waveShape
        {
            get;
            set;
        }

        ProfileWave _profileWave;
        [FilterOption("profileWave", "a wave file containing the wave shape to render from", IsFileName = true)]
        public string ProfileWave
        {
            set
            {
                _profileWave = new ProfileWave(value);
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
        HalfCycleKind _currentCycleKind;
        bool _currentSign;
        float _currentSample;

        public override void Rewind()
        {
            base.Rewind();
            _currentSampleNumber = 0xFFFFFFFF;
            _currentSample = 0;
            _currentSign = false;
            _baudSpec = _formatSpec.GetBaudSpec(_baudRate);
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        BaudSpec _baudSpec;
        int _baudRate = 300;
        [FilterOption("baud", "baud rate (default=300)")]
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
            return _currentSample;
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
                _currentSample = 0;
                _currentSign = false;

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
                _currentCycleKind = _input.GetHalfCycleKind();
                currentCycleLength = _currentCycleKind == HalfCycleKind.High ? highCycleTime : lowCycleTime;

                // Toggle
                _currentSign = !_currentSign;
            }

            _currentSample = _currentSign ? _volume : -_volume;

            if (_profileWave != null)
            {
                _currentSample = _profileWave.Interopolate(_currentCycleKind, _currentSample, currentTimeInCycle / currentCycleLength) * _volume;
            }
            else
            {
                // Apply wave shape...
                if (waveShape == WaveShape.sine)
                {
                    _currentSample = (float)(_currentSample * Math.Sin(currentTimeInCycle / currentCycleLength * Math.PI));
                }
            }

            return true;
        }
    }
}
