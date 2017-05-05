using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Microbee
{
    static class Conversions
    {
        [StreamConverter]
        public static IBlockStream ConvertStream(IAudioStream from)
        {
            return null;
        }

        [StreamConverter]
        public static IBlockStream ConvertStream(Audio.WaveReader from)
        {
            return null;
        }

    }
}
