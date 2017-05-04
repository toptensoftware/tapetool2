using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [StreamKind("single bit audio stream", "single bit audio stream")]
    abstract class FilterSingleBitAudioStream: FilterBitStream
    {
        public abstract int SampleRate { get; }
    }
}
