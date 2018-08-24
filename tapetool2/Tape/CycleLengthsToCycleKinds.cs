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
    [Filter("cycleLengthsToCycleKinds", "Generates cycle-kinds from cycle-lengths")]
    class CycleLengthsToCycleKinds : StreamBase, ICycleKindStream
    {
        public CycleLengthsToCycleKinds()
        {
        }

        ICycleLengthStream _input;
        int _samplesPerHighCycleMin;
        int _samplesPerHighCycleMax;
        int _samplesPerLowCycleMin;
        int _samplesPerLowCycleMax;

        [InputStream]
        public ICycleLengthStream Input
        {
            get { return _input; }
            set
            {
                _input = value;
            }
        }

        [FilterOption("highFreq", "frequency of high-frequency cycles (default=2400Hz)")]
        public int HighFreq
        {
            get;
            set;
        } = 2400;

        [FilterOption("lowFreq", "frequency of low-frequency cycles (default=1200Hz)")]
        public int LowFreq
        {
            get;
            set;
        } = 1200;

        [FilterOption("tolerance", "tolerance above below high/low freq in Hz (default= (highfreq-lowfreq)/3 )")]
        public int ToleranceFreq
        {
            get;
            set;
        }

        public override void Rewind()
        {
            base.Rewind();


            int toleranceFreq = ToleranceFreq == 0 ? (HighFreq - LowFreq) / 3 : ToleranceFreq;

            // Convert frequencies to sample counts
            _samplesPerHighCycleMin = _input.SampleRate / (HighFreq + toleranceFreq);
            _samplesPerHighCycleMax = _input.SampleRate / (HighFreq - toleranceFreq);
            _samplesPerLowCycleMin = _input.SampleRate / (LowFreq + toleranceFreq);
            _samplesPerLowCycleMax = _input.SampleRate / (LowFreq - toleranceFreq);

            _invalidCount = 0;
            _indeterminateCount = 0;
        }


        long _invalidCount;
        long _indeterminateCount;

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        CycleKind _currentCycleKind;

        protected override bool OnNext()
        {
            if (!_input.Next())
                return false;

            int cycleLength = _input.CurrentCycleLength;
            if (cycleLength < _samplesPerHighCycleMin)
            {
                _currentCycleKind = CycleKind.TooHigh;
                _invalidCount++;
            }
            else if (cycleLength <= _samplesPerHighCycleMax)
            {
                _currentCycleKind = CycleKind.High;
            }
            else if (cycleLength < _samplesPerLowCycleMin)
            {
                _currentCycleKind = CycleKind.Indeterminate;
                _indeterminateCount++;
            }
            else if (cycleLength <= _samplesPerLowCycleMax)
            {
                _currentCycleKind = CycleKind.Low;
            }
            else
            {
                _currentCycleKind = CycleKind.TooLow;
                _invalidCount++;
            }

            return true;
        }

        public CycleKind GetCycleKind()
        {
            return _currentCycleKind;
        }

        public int GetCurrentBaudRate()
        {
            return 0;
        }

        public override void WriteSummary(TextWriter w)
        {
            base.WriteSummary(w);

            int tol = ToleranceFreq == 0 ? (HighFreq - LowFreq) / 3 : ToleranceFreq;

            w.WriteLine("    indeterminate cycles: {0}", _indeterminateCount);
            w.WriteLine("    invalid cycles: {0}", _invalidCount);
            w.WriteLine("    high freq:   {0}Hz +/- {1}Hz", HighFreq, tol);
            w.WriteLine("    low freq:    {0}Hz +/- {1}Hz", LowFreq, tol);
            w.WriteLine("    short cycle: {0} - {1} samples", _samplesPerHighCycleMin, _samplesPerHighCycleMax);
            w.WriteLine("    long cycle:  {0} - {1} samples", _samplesPerLowCycleMin, _samplesPerLowCycleMax);
        }

    }
}
