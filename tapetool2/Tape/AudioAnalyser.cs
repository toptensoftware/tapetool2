using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Audio;

namespace tapetool2.Tape
{
    [Filter("analyse", "Analyses an audio stream for tape related characteristics")]
    class AudioAnalyser : StreamBase, IAudioStream
    {
        public AudioAnalyser()
        {
        }

        IAudioStream _input;

        [InputStream]
        public IAudioStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        public int ChannelCount
        {
            get { return _input.ChannelCount; }
        }

        public int SampleRate
        {
            get { return _input.SampleRate; }
        }

        public float GetSample(int channel)
        {
            return _input.GetSample(channel);
        }


        CycleLengthMethod? _userMethod;
        [FilterOption("cycleMethod", "sets the method used to measure cycle lengths (zc+, zc-, duty+ or duty-). Default = zc-")]
        public string cycleMethod
        {
            set
            {
                _userMethod = CycleLengthDetector.ParseMethod(value);
            }
        }


        CycleLengthDetector _cld = new CycleLengthDetector();

        // Measure the average duty cycle of any cycles longer than the average
        double MeasureAverageDutyCycle(CycleLengthMethod method, double avg)
        {
            base.Rewind();

            double total = 0;
            int count = 0;

            var cld = new CycleLengthDetector() { Method = method };
            for (int i=0; i<200; i++)
            {
                while (true)
                {
                    if (!_input.Next())
                        return -100;

                    int length = cld.Update(_input.GetSample(0));

                    if (length>avg)
                    {
                        var cdc = cld.CurrentDutyCycle();
                        total += cdc;
                        count++;
                        break;
                    }
                }
            }

            if (count == 0)
                return 0;
            return total / count;
        }

        // Measure the average length of the first 200 cycles
        public double MeasureAverageCycle()
        {
            base.Rewind();

            double total = 0;
            int count = 0;

            var cld = new CycleLengthDetector();
            for (int i = 0; i < 200; i++)
            {
                while (true)
                {
                    if (!_input.Next())
                        return -100;

                    int length = cld.Update(_input.GetSample(0));
                    if (length != 0)
                    {
                        total += length;
                        count++;
                        break;
                    }
                }
            }

            if (count == 0)
                return 0;
            return total / count;
        }

        CycleLengthMethod DetermineBestCycleLengthMethod()
        {
            var avg = MeasureAverageCycle();
            var dcUp = MeasureAverageDutyCycle(CycleLengthMethod.ZeroCrossingUp, avg);
            var dcDown = MeasureAverageDutyCycle(CycleLengthMethod.ZeroCrossingDown, avg);

            if (Math.Abs(dcUp - 0.5) < Math.Abs(dcDown - 0.5))
            {
                return CycleLengthMethod.ZeroCrossingUp;
            }
            else
            {
                return CycleLengthMethod.ZeroCrossingDown;
            }
        }

        bool bestCycleLengthMethodDetermined = false;

        public override void Rewind()
        {
            // Only need to do this once
            if (_userMethod.HasValue)
            {
                _cld.Method = _userMethod.Value;
            }
            else
            {
                if (!bestCycleLengthMethodDetermined)
                {
                    _cld.Method = DetermineBestCycleLengthMethod();
                    bestCycleLengthMethodDetermined = true;
                }
            }

            base.Rewind();

            _cld.Reset();
            _totalCycles = 0;
            _totalSamples = 0;
            _shortestCycle = 0;
            _longestCycle = 0;
            _cycleDistribution.Clear();
        }

        long _totalSamples;
        long _totalCycles;
        int _shortestCycle;
        int _longestCycle;
        Dictionary<int, long> _cycleDistribution = new Dictionary<int, long>();

        void ProcessCycle(int samples)
        {
            if (samples == 0)
                return;

            _totalCycles++;

            if (samples < _shortestCycle || _shortestCycle == 0)
                _shortestCycle = samples;
            if (samples > _longestCycle)
                _longestCycle = samples;         

            // Update distribution counts
            long dcount = 0;
            _cycleDistribution.TryGetValue(samples, out dcount);
            dcount++;
            _cycleDistribution[samples] = dcount;
        }

        protected override bool OnNext()
        {
            if (!_input.Next())
            {
                ProcessCycle(_cld.CurrentCycleLength());
                return false;
            }

            _totalSamples++;

            // Detect zero crossings
            int cycleLength = _cld.Update(_input.GetSample(0));
            if (cycleLength != 0)
                ProcessCycle(cycleLength);

            return true;
        }

        public int BitsPerSample
        {
            get { return _input.BitsPerSample; }
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        long CycleFreqCount(int samples)
        {
            long dcount = 0;
            _cycleDistribution.TryGetValue(samples, out dcount);
            return dcount;
        }


        double AvgCycleFreqCount(int samples)
        {
            int avgPeriod = _input.SampleRate / 4000;

            long sum = 0;
            for (int i=samples - avgPeriod / 2; i <= samples + avgPeriod / 2; i++)
            {
                sum += CycleFreqCount(i);
            }
            return (double)sum / avgPeriod;
        }

        double WeightedCycleFreqCount(int samples)
        {
            return CycleFreqCount(samples) + AvgCycleFreqCount(samples);
        }

        bool IsLocalMinimaBetween(int sampleLengthA, int sampleLengthB)
        {
            if (sampleLengthB < sampleLengthA)
            {
                int temp = sampleLengthA;
                sampleLengthA = sampleLengthB;
                sampleLengthB = temp;
            }

            for (int i=sampleLengthA + 1; i <= sampleLengthB - 1; i++)
            {
                if (WeightedCycleFreqCount(i) <= WeightedCycleFreqCount(i - 1) &&
                    WeightedCycleFreqCount(i) >= WeightedCycleFreqCount(i + 1))
                    return true;
            }
            return false;
        }

        public override void WriteSummary(TextWriter w)
        {
            base.WriteSummary(w);
            w.WriteLine("    total samples: {0}", _totalSamples);
            w.WriteLine("    total cycles: {0}", _totalCycles);
            w.WriteLine("    average cycle:  {0:0.00} samples ({1:0.00}Hz)", (double)_totalSamples / _totalCycles, (double)_input.SampleRate / ((double)_totalSamples / _totalCycles));
            w.WriteLine("    cycle method: {0}", _cld.Method);
            w.WriteLine();

            var freqRank = Enumerable.Range(_shortestCycle, _longestCycle - _shortestCycle + 1).OrderByDescending(x => AvgCycleFreqCount(x) + CycleFreqCount(x)).ToList();

            int mostFreq = freqRank[0];
            int nextMostFreqIndex = 1;
            while (nextMostFreqIndex < freqRank.Count &&
                    !IsLocalMinimaBetween(mostFreq, freqRank[nextMostFreqIndex]))
            {
                nextMostFreqIndex++;
            }
            int nextMostFreq = freqRank[nextMostFreqIndex];

            int shortCycleLength = Math.Min(mostFreq, nextMostFreq);
            int longCycleLength = Math.Max(mostFreq, nextMostFreq);
            
            w.WriteLine("    cycle distribution");
            for (int i=_shortestCycle; i<=_longestCycle; i++)
            {
                string indicator = "";

                if (i == shortCycleLength || i == longCycleLength)
                    indicator = "*";

                w.WriteLine("    {0,10} {1,10:0.00}Hz: {2,10} {3,10:0.0} {4,10:0.0} #{5} {6}", i,
                        (double)_input.SampleRate / i,
                        CycleFreqCount(i), AvgCycleFreqCount(i),
                        CycleFreqCount(i) + AvgCycleFreqCount(i),
                        freqRank.IndexOf(i) + 1,
                        indicator
                        );
            }
        }
    }
}
