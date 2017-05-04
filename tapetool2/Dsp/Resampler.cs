using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    class Resampler
    {
        public enum Quality
        {
            Low,
            Medium,
            High,
        }

        // Creates a resampler for the specified sample conversion and quality
        public Resampler(int sourceSampleRate, int targetSampleRate, Quality quality)
        {
            // Get the appropriate sinc curve
            _sincCurve = SincCurve.Get(quality);

            _sourceSampleRate = sourceSampleRate;
            _targetSampleRate = targetSampleRate;

            _convRate = _targetSampleRate / _sourceSampleRate;
            _invConvRate = _sourceSampleRate / _targetSampleRate;
            _lookupIncrement = _sincCurve.ResolutionPerZeroCrossing * 2;

            // Up or down?
            _up = targetSampleRate > sourceSampleRate;

            // How many samples either side of the source sample are needed
            _requiredSurroundingSamples = _up ? _sincCurve.ZeroCrossings : (int)((double)_sincCurve.ZeroCrossings * _invConvRate);

            // Some margin for rounding error
            _requiredSurroundingSamples += 2;
        }

        // The number of samples the resampler requires either side of the current source sample
        public int RequiredSurroundingSamples
        {
            get { return _requiredSurroundingSamples; }
        }

        public double InverseConversionRate
        {
            get { return _invConvRate; }
        }

        public double ConversionRate
        {
            get { return _convRate; }
        }

        // Resample
        //   - srcSample is the sample number in the source sample buffer
        //   - sourceSample is the source sample buffer with at least RequiredSurroundingSample before and after srcSample
        public double Resample(double[] sourceSamples, double srcSample)
        {
            System.Diagnostics.Debug.Assert(srcSample - RequiredSurroundingSamples >= 0);
            System.Diagnostics.Debug.Assert(srcSample + RequiredSurroundingSamples < sourceSamples.Length);

            if (_up)
                return ResampleUp(sourceSamples, srcSample);
            else
                return ResampleDown(sourceSamples, srcSample);
        }

        SincCurve _sincCurve;
        double _sourceSampleRate;
        double _targetSampleRate;
        double _invConvRate;
        double _convRate;
        int _lookupIncrement;
        int _requiredSurroundingSamples;
        bool _up;

        double ResampleUp(double[] sourceSamples, double srcSample)
        {
            int iSrcSample = (int)srcSample;
            double[] curve = _sincCurve.CurveAndDeltas;
            double dblTotal1 = 0;

            // Process left half of sinc curve
            double dblPhaseL = srcSample - (double)iSrcSample;
            double dblFilterIndex = dblPhaseL * _sincCurve.ResolutionPerZeroCrossing;
            int iFilterIndex = (int)dblFilterIndex;
            double dblInterp = dblFilterIndex - (double)iFilterIndex;
            int curvePos = iFilterIndex * 2;
            for (int i= iSrcSample; i > iSrcSample - _sincCurve.ZeroCrossings; i--)
            {
                double dblSinc = curve[curvePos + 1] * dblInterp + curve[curvePos];
                dblTotal1 += dblSinc * sourceSamples[i];
                curvePos += _lookupIncrement;
            }

            // Process right half of sinc curve
            double dblPhaseR = 1.0 - dblPhaseL;
            dblFilterIndex = dblPhaseR * _sincCurve.ResolutionPerZeroCrossing;
            iFilterIndex = (int)dblFilterIndex;
            dblInterp = dblFilterIndex - (double)iFilterIndex;
            curvePos = iFilterIndex * 2;
            for (int i= iSrcSample; i < iSrcSample + _sincCurve.ZeroCrossings; i++)
            {
                double dblSinc = curve[curvePos + 1] * dblInterp + curve[curvePos];
                dblTotal1 += dblSinc * sourceSamples[i];
                curvePos += _lookupIncrement;
            }

            return dblTotal1;

        }

        const int FP_FRACTION = 0x0001FFFF;
        const int FP_SHIFT = 17;
        const double dblInvFp1 = 1.0 / (double)FP_FRACTION;


        double ResampleDown(double[] sourceSamples, double srcSample)
        {
            // Calculate number of interations of the internal left/right loops
            int iIterations = (int)((double)_sincCurve.ZeroCrossings * _invConvRate);

            // Calculate fp fraction * sinc resolution
            double dblFp1ByRes = (double)FP_FRACTION * _sincCurve.ResolutionPerZeroCrossing;

            // Calculate fp increment per internal left/right loop
            uint iIncrement = (uint)(dblFp1ByRes * _targetSampleRate / _sourceSampleRate);

            double[] curve = _sincCurve.CurveAndDeltas;
            double dblTotal1 = 0;

            // Process left half of sinc curve
            int iSrcSample = (int)(srcSample);
            double dblPhaseL = (srcSample - (double)iSrcSample) * _convRate;
            uint iFilterIndexFP = (uint)(dblPhaseL * dblFp1ByRes);
            for (int i = iSrcSample; i > iSrcSample - iIterations; i--)
            {
                double dblFilterInterp = (double)(iFilterIndexFP & FP_FRACTION) * dblInvFp1;
                uint iFilterIndex = (iFilterIndexFP >> FP_SHIFT) * 2;
                double dblSinc = curve[iFilterIndex + 1] * dblFilterInterp + curve[iFilterIndex];
                dblTotal1 += dblSinc * sourceSamples[i];
                iFilterIndexFP += iIncrement;
            }

            // Process right half of sinc curve
            // Calculate phase R
            double dblPhaseR = _convRate - dblPhaseL;
            iFilterIndexFP = (uint)(dblPhaseR * dblFp1ByRes);
            for (int i= iSrcSample; i<iSrcSample + iIterations; i++)
            {
                double dblFilterInterp = (double)(iFilterIndexFP & FP_FRACTION) * dblInvFp1;
                uint iFilterIndex = (iFilterIndexFP >> FP_SHIFT) * 2;
                double dblSinc = curve[iFilterIndex + 1] * dblFilterInterp + curve[iFilterIndex];
                dblTotal1 += dblSinc * sourceSamples[i];
                iFilterIndexFP += iIncrement;
            }

            return dblTotal1 * _convRate;
        }

        public class SincCurve
        {
            static SincCurve[] _curves;

            public static SincCurve Get(Quality quality)
            {
                if (_curves == null)
                    _curves = new SincCurve[3];

                if (_curves[(int)quality] == null)
                    _curves[(int)quality] = new SincCurve(quality);

                return _curves[(int)quality];
            }

            private SincCurve(Quality quality)
            {
                switch (quality)
                {
                    case Quality.Low:
                        Init(19, 128, 8.31472372954840555082e-01, 9.7);
                        break;

                    case Quality.Medium:
                        Init(41, 128, 9.20381425342432724079e-01, 9.7);
                        break;

                    case Quality.High:
                        Init(133, 128, 9.73822959712628111184e-01, 9.7);
                        break;
                }
            }

            int _zeroCrossings;
            int _resolutionPerZeroCrossing;
            int _totalPoints;
            double _freq;
            double _kaiserAlpha;
            double[] _curveAndDeltas;

            public int ZeroCrossings
            {
                get { return _zeroCrossings; }
            }

            public int ResolutionPerZeroCrossing
            {
                get { return _resolutionPerZeroCrossing; }
            }

            public double[] CurveAndDeltas
            {
                get { return _curveAndDeltas; }
            }

            // Constructor
            void Init(int iZeroCrossings, int iResolutionPerZeroCrossing, double dblFreq, double dblKaiserAlpha)
            {
                // Store attributes
                _freq = dblFreq;
                _kaiserAlpha = dblKaiserAlpha;

                // Allocate temp memory for the curve
                int iTotalPoints = iZeroCrossings * iResolutionPerZeroCrossing;
                double[] pCurve = new double[iTotalPoints];

                // Calculate sinc curve
                CalcHalfSinc(iZeroCrossings, iTotalPoints, dblFreq, pCurve);

                // Apply Kaiser window
                ApplyKaiser(dblKaiserAlpha, iTotalPoints, pCurve);

                // Init self
                Init(iZeroCrossings, iResolutionPerZeroCrossing, pCurve);
            }


            void Init(int zc, int res, double[] curve)
            {
                // Store attributes
                _zeroCrossings = zc;
                _resolutionPerZeroCrossing = res;
                _totalPoints = _zeroCrossings * _resolutionPerZeroCrossing;

                // Allocate memory for the curve
                _curveAndDeltas = new double[(_totalPoints + 2) * 2];

                // (include 2 extra points, one for the Nth crossing, and one for the
                //		value after - basically a little margin on the boundaries, to 
                //		save doing boundary checks during resampling)
                _curveAndDeltas[_totalPoints * 2] = 0;
                _curveAndDeltas[_totalPoints * 2 + 1] = 0;
                _curveAndDeltas[(_totalPoints + 1) * 2] = 0;
                _curveAndDeltas[(_totalPoints + 1) * 2 + 1] = 0;

                // Copy curve
                for (int i = 0; i < _totalPoints; i++)
                {
                    _curveAndDeltas[i * 2] = curve[i];
                }

                // Calculate deltas
                for (int i = 0; i < _totalPoints + 1; i++)
                {
                    _curveAndDeltas[i * 2 + 1] = _curveAndDeltas[(i + 1) * 2] - _curveAndDeltas[i * 2];
                }
            }

            // Calculates right half of a sinc curve
            void CalcHalfSinc(double dblZeroCrossings, int nCount, double dblRollOffFreq, double[] pdblSinc)
            {
                // Calculate sinc
                pdblSinc[0] = dblRollOffFreq;
                for (int i = 1; i < nCount; i++)
                {
                    double dblX = Math.PI * i / nCount * dblZeroCrossings;
                    pdblSinc[i] = Math.Sin(dblX * dblRollOffFreq) / dblX;
                }
            }

            double sqr(double x)
            {
                return x * x;
            }

            // Computes the 0th order modified bessel function of the first kind
            double I0(double x)
            {
                double dblSum = 1.0;
                double dblHalfX = x / 2.0;
                double dblDiv = 1.0;
                double dblU = 1.0;

                while (true)
                {
                    double dblTemp = dblHalfX / dblDiv;
                    dblDiv += 1.0;

                    dblTemp *= dblTemp;
                    dblU *= dblTemp;
                    dblSum += dblU;

                    if (dblU < 1E-21 * dblSum)
                        return dblSum;
                }
            }

            // Calculate a kaiser window
            void CalcKaiser(double dblAlpha, int nCount, double[] pdblKaiser)
            {
                double dblI0 = I0(dblAlpha);
                for (int i = 0; i < nCount; i++)
                {
                    pdblKaiser[i] = I0(dblAlpha * Math.Sqrt(1.0 - sqr((double)(i) / (double)(nCount - 1)))) / dblI0;
                }
            }


            // Calculate and apply a kaiser window
            void ApplyKaiser(double dblAlpha, int nCount, double[] pdblSeries)
            {
                double dblI0 = I0(dblAlpha);
                for (int i = 0; i < nCount; i++)
                {
                    pdblSeries[i] *= I0(dblAlpha * Math.Sqrt(1.0 - sqr((double)(i) / (double)(nCount - 1)))) / dblI0;
                }
            }



        }
    }
}
