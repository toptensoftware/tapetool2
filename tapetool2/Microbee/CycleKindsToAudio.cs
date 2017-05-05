using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace tapetool2.Microbee
{
    [Filter("microbee.cycleKindsToAudio", "Generates Microbee audio cycles from a cycle kind stream")]
    class CycleKindsToAudio : StreamBase, IAudioStream
    {
        public CycleKindsToAudio()
        {
        }

        ICycleKindStream _source;
    
        [Source]
        public ICycleKindStream Source
        {
            get { return _source; }
            set
            {
                _source = value;
            }
        }

        int _sampleRate = 24000;
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
        public int Volume
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

        public override IEnumerable<IStream> GetPrecedents()
        {
            yield return _source;
        }

        const double highCycleTime = 1.0 / 2400;
        const double lowCycleTime = 1.0 / 1200;

        public float GetSample(int channel)
        {
            return _currentSample ? _volume : -_volume;
        }

        public override bool Next()
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
                return _source.Next();
            }

            double currentTime = (double)_currentSampleNumber / _sampleRate;
            double currentTimeInCycle = currentTime - _currentCycleTime;
            double currentCycleLength = _source.GetCycleKind() == CycleKind.High ? highCycleTime : lowCycleTime;

            if (currentTimeInCycle >= currentCycleLength)
            {
                // Get the next cycle kind
                if (!_source.Next())
                    return false;

                _currentCycleTime += currentCycleLength;
                currentTimeInCycle = currentTime - _currentCycleTime;
                currentCycleLength = _source.GetCycleKind() == CycleKind.High ? highCycleTime : lowCycleTime;
            }

            _currentSample = currentTimeInCycle < currentCycleLength / 2;

            return true;
        }
    }
}
