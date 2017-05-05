using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace tapetool2.Microbee
{
    [Filter("microbee.audioToCycleKinds", "Generates Microbee audio cycles from a cycle kind stream")]
    class AudioToCycleKinds : StreamBase, ICycleKindStream
    {
        public AudioToCycleKinds()
        {
        }

        IAudioStream _input;
        int _samplesPerHighCycle;
        int _samplesPerLowCycle;
        int _sampleMargin;
        int _currentCycleSamples;
    
        [InputStream]
        public IAudioStream Input
        {
            get { return _input; }
            set
            {
                _input = value;
            }
        }

        public override void Rewind()
        {
            base.Rewind();

            // Find the first positive sample 
            while (_input.Next() && _input.GetSample(0) <= 0)
            {
            }

            _samplesPerHighCycle = _input.SampleRate / 2400;
            _samplesPerLowCycle = _input.SampleRate / 1200;
            _sampleMargin = (_samplesPerLowCycle - _samplesPerHighCycle) / 3;
        }

        // Find the next zero crossing and return the number of samples passed
        int FindZeroCrossing()
        {
            int samples = 0;
            float prevSample = _input.GetSample(0);

            while (true)
            {
                if (!_input.Next())
                    return samples == 0 ? -1 : samples;

                var currentSample = _input.GetSample(0);

                samples++;

                if (prevSample <= 0 && currentSample > 0)
                    return samples;

                prevSample = currentSample;

            }
        }

        public override IEnumerable<IStream> GetInputs()
        {
            yield return _input;
        }

        const double highCycleTime = 1.0 / 2400;
        const double lowCycleTime = 1.0 / 1200;

        public int GetCurrentBaudRate()
        {
            // We don't know!
            return 0;
        }

        public CycleKind GetCycleKind()
        {
            if (_currentCycleSamples < _samplesPerHighCycle - _sampleMargin)
                return CycleKind.TooHigh;
            if (_currentCycleSamples < _samplesPerHighCycle + _sampleMargin)
                return CycleKind.High;
            if (_currentCycleSamples < _samplesPerLowCycle - _sampleMargin)
                return CycleKind.Indeterminate;
            if (_currentCycleSamples < _samplesPerLowCycle + _sampleMargin)
                return CycleKind.Low;
            return CycleKind.TooLow;
        }

        public override bool Next()
        {
            _currentCycleSamples = FindZeroCrossing();
            return _currentCycleSamples >= 0;
        }

    }
}
