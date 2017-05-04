using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Microbee
{
    [Filter("microbeeAudioCycleGenerator", "Generates Microbee audio cycles from a cycle kind stream")]
    class FilterAudioCycleGenerator : FilterSingleBitAudioStream
    {
        public FilterAudioCycleGenerator()
        {
        }

        FilterCycleKindStream _source;
    
        [Source]
        public FilterCycleKindStream Source
        {
            get { return _source; }
            set
            {
                _source = value;
            }
        }

        int _sampleRate = 24000;

        [FilterOption("sampleRate", "sample rate at which to render")]
        public int SampleRateOption
        {
            set
            {
                _sampleRate = value;
            }
        }

        public override int SampleRate
        {
            get
            {
                return _sampleRate;
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

        public override IEnumerable<Filter> GetPrecedents()
        {
            yield return _source;
        }

        const double highCycleTime = 1.0 / 2400;
        const double lowCycleTime = 1.0 / 1200;

        public override bool GetSample()
        {
            return _currentSample;
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
