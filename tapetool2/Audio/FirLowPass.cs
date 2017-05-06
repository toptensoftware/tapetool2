using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Audio
{
    [Filter("lowPass", "Applies a low-pass filter to an audio stream")]
    class FirLowPass : Fir
    {
        public FirLowPass()
        {
            _freqHigh = 3600;
        }

        [FilterOption("freq", "Cutoff frequency (default=3600)")]
        public int Freq
        {
            get { return _freqHigh; }
            set { _freqHigh = value; }
        }

    }
}
