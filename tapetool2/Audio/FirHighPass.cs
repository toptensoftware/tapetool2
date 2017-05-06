using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Audio
{
    [Filter("highPass", "Applies a high-pass filter to an audio stream")]
    class FirHighPass : Fir
    {
        public FirHighPass()
        {
            _freqLow = 600;
        }

        [FilterOption("freq", "Cutoff frequency (default=600)")]
        public int Freq
        {
            get { return _freqLow; }
            set { _freqLow = value; }
        }

    }
}
