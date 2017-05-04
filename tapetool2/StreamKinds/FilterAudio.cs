using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [StreamKind("audio stream", "audio stream")]
    abstract class FilterAudio : Filter
    {
        public abstract int ChannelCount { get; }
        public abstract int SampleRate { get; }
        public abstract float GetSample(int channel);
        public abstract int BitsPerSample { get; } 
    }
}
