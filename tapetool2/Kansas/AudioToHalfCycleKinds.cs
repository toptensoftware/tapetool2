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
    [Filter("kansas.audioToHalfCycleKinds", "Generates Kansas City audio half-cycles from an audio stream")]
    class AudioToHalfCycleKinds : StreamBase, IHalfCycleKindStream
    {
        public AudioToHalfCycleKinds()
        {
        }

        FormatSpec _formatSpec = FormatSpec.KansasCity;
        public void SetFormatSpec(FormatSpec spec)
        {
            _formatSpec = spec;
        }

        IAudioStream _input;
        int _samplesPerHighHalfCycle;
        int _samplesPerLowHalfCycle;
        int _sampleMargin;
        int _currentCycleSamples;
        HalfCycleLengthDetector _cld = new HalfCycleLengthDetector();

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

            _baudSpec = _formatSpec.GetBaudSpec(_baudRate);

            // Find the first positive sample 
            while (_input.Next() && _input.GetSample(0) <= 0)
            {
            }

            _cld.Reset();

            _samplesPerHighHalfCycle = (_input.SampleRate /  (_baudSpec.LowFrequency * 2)) / 2;
            _samplesPerLowHalfCycle = (_input.SampleRate / _baudSpec.LowFrequency) / 2;
            _sampleMargin = (_samplesPerLowHalfCycle - _samplesPerHighHalfCycle) / 2 - 1;
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

        public int GetCurrentBaudRate()
        {
            // We don't know!
            return 0;
        }

        public HalfCycleKind GetHalfCycleKind()
        {
            if (_currentCycleSamples < _samplesPerHighHalfCycle - _sampleMargin)
                return HalfCycleKind.TooHigh;
            if (_currentCycleSamples <= _samplesPerHighHalfCycle + _sampleMargin)
                return HalfCycleKind.High;
            if (_currentCycleSamples < _samplesPerLowHalfCycle - _sampleMargin)
                return HalfCycleKind.Indeterminate;
            if (_currentCycleSamples <= _samplesPerLowHalfCycle + _sampleMargin)
                return HalfCycleKind.Low;
            return HalfCycleKind.TooLow;
        }

        protected override bool OnNext()
        {
            _currentCycleSamples = FindZeroCrossing();
            if (_currentCycleSamples < 0)
            {
                return false;
            }
                    
            switch (GetHalfCycleKind())
            {
                case HalfCycleKind.Indeterminate:
                    _indeterminateCount++;
                    break;

                case HalfCycleKind.TooHigh:
                case HalfCycleKind.TooLow:
                    _invalidCount++;
                    break;
            }

            return true;
        }

        public override void WriteSummary(TextWriter w)
        {
            base.WriteSummary(w);
            w.WriteLine("    indeterminate cycles: {0}", _indeterminateCount);
            w.WriteLine("    invalid cycles: {0}", _invalidCount);
            w.WriteLine("    short cycle: {0} - {1}", _samplesPerHighHalfCycle - _sampleMargin, _samplesPerHighHalfCycle + _sampleMargin);
            w.WriteLine("    long cycle:  {0} - {1}", _samplesPerLowHalfCycle - _sampleMargin, _samplesPerLowHalfCycle + _sampleMargin);
        }
    }
}
