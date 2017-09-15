using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Audio;
using tapetool2.Tape;

namespace tapetool2.Microbee
{
    [Filter("microbee.cycleKindsToAudio", "Generates Microbee audio cycles from a cycle kind stream")]
    class CycleKindsToAudio : StreamBase, IAudioStream
    {
        public CycleKindsToAudio()
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
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        const double highCycleTime = 1.0 / 2400;
        const double lowCycleTime = 1.0 / 1200;

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
            double currentCycleLength = _input.GetCycleKind() == CycleKind.High ? highCycleTime : lowCycleTime;

            if (currentTimeInCycle >= currentCycleLength)
            {
                // Get the next cycle kind
                if (!_input.Next())
                    return false;

                _currentCycleTime += currentCycleLength;
                currentTimeInCycle = currentTime - _currentCycleTime;
                currentCycleLength = _input.GetCycleKind() == CycleKind.High ? highCycleTime : lowCycleTime;
            }

            _currentSample = currentTimeInCycle < currentCycleLength / 2;

            return true;
        }
    }
}
