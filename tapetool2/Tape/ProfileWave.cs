using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Audio;

namespace tapetool2.Tape
{
    public class ProfileWave
    {
        public ProfileWave(string filename)
        {
            // Create wave reader
            using (var waveReader = new WaveReader())
            {
                waveReader.Filename = filename;
                waveReader.Rewind();
                waveReader.Next();

                // Get the current sample 
                var current = waveReader.GetSample(0);
                var sign = current < 0 ? -1 : 1;

                // Wait till it crosses
                while (true)
                {
                    if (!waveReader.Next())
                    {
                        throw new InvalidOperationException("Invalid profile wave");
                    }

                    // Crossed?
                    var newSign = waveReader.GetSample(0) < 0 ? -1 : 1;
                    if (newSign != sign)
                        break;
                }


                // read the next two cycles
                _lowCycleA = ReadCycle(waveReader);
                _lowCycleB = ReadCycle(waveReader);
                _highCycleA = ReadCycle(waveReader);
                _highCycleB = ReadCycle(waveReader);

                // Swap if out of order
                if (_lowCycleA.Count + _lowCycleB.Count < _highCycleA.Count + _highCycleB.Count)
                {
                    var temp = _lowCycleA;
                    _lowCycleA = _highCycleA;
                    _highCycleA = temp;

                    temp = _lowCycleB;
                    _lowCycleB = _highCycleB;
                    _highCycleB = temp;
                }

                // Normalize the cycles
                var max = _lowCycleA.Max();
                max = Math.Max(max, _lowCycleB.Max());
                max = Math.Max(max, _highCycleA.Max());
                max = Math.Max(max, _highCycleB.Max());

                var scale = 1.0f / max;
                Normalize(_lowCycleA, scale);
                Normalize(_lowCycleB, scale);
                Normalize(_highCycleA, scale);
                Normalize(_highCycleB, scale);
            }
        }

        public void Normalize(List<float> wave, float scale)
        {
            for (int i = 0; i < wave.Count; i++)
            {
                wave[i] *= scale;
            }
        }

        public float Interopolate(HalfCycleKind kind, float squareValue, double position)
        {
            List<float> wave;
            if (squareValue > 0)
            {
                wave = kind == HalfCycleKind.Low ? _highCycleA : _lowCycleA;
            }
            else
            {
                wave = kind == HalfCycleKind.High ? _highCycleB : _lowCycleB;
            }

            // Work out sample pos
            double samplePos = position * wave.Count;
            int sampleA = (int)Math.Floor(samplePos);
            if (sampleA < 0)
                return wave[0];
            if (sampleA + 1 >= wave.Count)
                return wave[wave.Count - 1];

            return wave[sampleA];
            /*
            // Interopolate (should really sinc resample, but assume using a high resolution profile wave)
            double frac = samplePos - sampleA;
            return (float)(wave[sampleA] + wave[sampleA + 1] - wave[sampleA] * frac);
            */
        }

        List<float> _lowCycleA;
        List<float> _lowCycleB;
        List<float> _highCycleA;
        List<float> _highCycleB;

        List<float> ReadCycle(WaveReader wr)
        {
            var wave = new List<float>();

            var sample = wr.GetSample(0);
            wave.Add(sample);

            int crossings = 0;

            // Wait till it crosses twice
            while (crossings < 1)
            {
                if (!wr.Next())
                {
                    throw new InvalidOperationException("Invalid profile wave");
                }

                var lastSample = sample;

                // Get the next sample
                sample = wr.GetSample(0);
                wave.Add(sample);

                // Crossed?
                if (sample < 0 != lastSample < 0)
                {
                    crossings++;
                }
            }

            // Replace the final cross value with 0
            wave[wave.Count - 1] = 0;
            return wave;
        }
    }
}
