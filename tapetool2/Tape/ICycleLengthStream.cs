using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Tape
{
    [StreamKind("cycle length kind stream", "cycle length stream")]
    interface ICycleLengthStream : IStream
    {
        int CurrentCycleLength { get; }
        int SampleRate { get; }
    }
}
