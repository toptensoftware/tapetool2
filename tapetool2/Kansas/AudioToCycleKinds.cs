using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Audio;
using tapetool2.Tape;

namespace tapetool2.Kansas
{
    [Filter("kansas.audioToCycleKinds", "Generates Kansas City audio cycles from a cycle kind stream")]
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
        CycleLengthDetector _cld = new CycleLengthDetector() { Method = CycleLengthMethod.ZeroCrossingDown };
    
        [InputStream]
        public IAudioStream Input
        {
            get { return _input; }
            set
            {
                _input = value;
            }
        }
        
        [FilterOption("cycleMethod", "sets the method used to measure cycle lengths (zc+, zc-, duty+ or duty-). Default = zc-")]
        public string cycleMethod
        {
            set
            {
                _cld.Method = CycleLengthDetector.ParseMethod(value);
            }
        }

        public override void Rewind()
        {
            base.Rewind();

            // Find the first positive sample 
            while (_input.Next() && _input.GetSample(0) <= 0)
            {
            }

            _cld.Reset();

            _samplesPerHighCycle = _input.SampleRate / 2400;
            _samplesPerLowCycle = _input.SampleRate / 1200;
            _sampleMargin = (_samplesPerLowCycle - _samplesPerHighCycle) / 2 - 1;
            _eof = false;
            _invalidCount = 0;
            _indeterminateCount = 0;
        }

        bool _eof;
        long _invalidCount;
        long _indeterminateCount;


        // Find the next zero crossing and return the number of samples passed
        int FindZeroCrossing()
        {
            if (_eof)
                return -1;
            while (_input.Next())
            {
                int samples = _cld.Update(_input.GetSample(0));
                if (samples != 0)
                    return samples;
            }

            _eof = true;
            return _cld.CurrentCycleLength();
        }

        public override IEnumerable<IStream> EnumStreams()
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
            if (_currentCycleSamples <= _samplesPerHighCycle + _sampleMargin)
                return CycleKind.High;
            if (_currentCycleSamples < _samplesPerLowCycle - _sampleMargin)
                return CycleKind.Indeterminate;
            if (_currentCycleSamples <= _samplesPerLowCycle + _sampleMargin)
                return CycleKind.Low;
            return CycleKind.TooLow;
        }

        protected override bool OnNext()
        {
            _currentCycleSamples = FindZeroCrossing();
            if (_currentCycleSamples < 0)
            {
                return false;
            }
                    
            switch (GetCycleKind())
            {
                case CycleKind.Indeterminate:
                    _indeterminateCount++;
                    break;

                case CycleKind.TooHigh:
                case CycleKind.TooLow:
                    _invalidCount++;
                    break;
            }

            return true;
        }

        public override void WriteSummary(TextWriter w)
        {
            base.WriteSummary(w);
            w.WriteLine("    cycle method: {0}", _cld.Method.ToString());
            w.WriteLine("    indeterminate cycles: {0}", _indeterminateCount);
            w.WriteLine("    invalid cycles: {0}", _invalidCount);
            w.WriteLine("    short cycle: {0} - {1}", _samplesPerHighCycle - _sampleMargin, _samplesPerHighCycle + _sampleMargin);
            w.WriteLine("    long cycle:  {0} - {1}", _samplesPerLowCycle - _sampleMargin, _samplesPerLowCycle + _sampleMargin);

        }

    }
}
