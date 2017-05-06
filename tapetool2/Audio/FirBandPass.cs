using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Audio
{
    [Filter("bandPass", "Applies a band-pass filter to an audio stream")]
    class FirBandPass : Fir
    {
        public FirBandPass()
        {
            _freqLow = 600;
            _freqHigh = 3600;
        }

        [FilterOption("low", "Low cutoff frequency (default=600)")]
        public int Low
        {
            get { return _freqLow; }
            set { _freqLow = value; }
        }

        [FilterOption("high", "High cutoff frequency (default=3600)")]
        public int High
        {
            get { return _freqHigh; }
            set { _freqHigh = value; }
        }

    }
}
