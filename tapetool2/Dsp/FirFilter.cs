using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    class FirFilter
    {
        // Ported from this: https://cardinalpeak.com/blog/a-c-class-to-implement-low-pass-high-pass-and-band-pass-filters/

        // FIR filter
        // Pass freqLow!=0 for high pass
        // Pass freqHigh!=0 for low pass
        // Pass both freqLow and freqHigh for band pass
        public FirFilter(int numTaps, double sampleRate, double freqLow, double freqHigh)
        {
            _taps = new double[numTaps];
            _sr = new double[numTaps];

            if (freqLow != 0.0 && freqHigh != 0)
                DesignBandPass(sampleRate, freqLow, freqHigh);
            else if (freqLow != 0.0)
                DesignHighPass(sampleRate, freqLow);
            else if (freqHigh != 0.0)
                DesignLowPass(sampleRate, freqHigh);
            else
                throw new ArgumentException("Must specify at least low or high frequency cutoff");
        }

        // Process one sample
        public double ProcessSample(double data_sample)
        {
            int numTaps = _taps.Length;
            for (int i = numTaps - 1; i >= 1; i--)
            {
                _sr[i] = _sr[i - 1];
            }
            _sr[0] = data_sample;

            double result = 0;
            for (int i = 0; i < numTaps; i++)
                result += _sr[i] * _taps[i];

            return result;
        }

        public int TapCount
        {
            get
            {
                return _taps.Length;
            }
        }


        double[] _taps;
        double[] _sr;

        void DesignLowPass(double sampleRate, double freq)
        {
            double lambda = Math.PI * freq / (sampleRate / 2);

            int numTaps = _taps.Length;
            for (int n = 0; n < numTaps; n++)
            {
                double mm = n - (numTaps - 1.0) / 2.0;
                if (mm == 0.0)
                    _taps[n] = lambda / Math.PI;
                else
                    _taps[n] = Math.Sin(mm * lambda) / (mm * Math.PI);
            }

            return;
        }

        void DesignHighPass(double sampleRate, double freq)
        {
            double lambda = Math.PI * freq / (sampleRate / 2);

            int numTaps = _taps.Length;
            for (int n = 0; n < numTaps; n++)
            {
                double mm = n - (numTaps - 1.0) / 2.0;

                /*
                if (mm == 0.0)
                    _taps[n] = 1.0 - lambda / Math.PI;
                else
                    _taps[n] = -Math.Sin(mm * lambda) / (mm * Math.PI);
                */

                // See comments in above linked article
                if (mm == 0.0)
                    _taps[n] = (Math.PI - lambda) / Math.PI;
                else
                    _taps[n] = (Math.Sin(mm * Math.PI) - Math.Sin(mm * lambda)) / (mm * Math.PI);
            }


            return;
        }

        void DesignBandPass(double sampleRate, double freqLow, double freqHigh)
        {
            double lambda = Math.PI * freqLow / (sampleRate / 2);
            double phi = Math.PI * freqHigh / (sampleRate / 2);

            int numTaps = _taps.Length;
            for (int n = 0; n < numTaps; n++)
            {
                double mm = n - (numTaps - 1.0) / 2.0;
                if (mm == 0.0)
                    _taps[n] = (phi - lambda) / Math.PI;
                else
                    _taps[n] = (Math.Sin(mm * phi) -
                                     Math.Sin(mm * lambda)) / (mm * Math.PI);
            }

            return;
        }

    }
}
