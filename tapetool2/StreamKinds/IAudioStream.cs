using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [StreamKind("audio stream", "audio stream")]
    interface IAudioStream : IStream
    {
        int ChannelCount { get; }
        int SampleRate { get; }
        int BitsPerSample { get; }
        float GetSample(int channel);
    }
}
