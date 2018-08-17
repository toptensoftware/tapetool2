using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Tape
{
    // When parsing/generating cassette tape audio
    // cycles are of two frequencies - High and Low
    // For Microbee High Freq = 2400Hz, Low = 1200Hz
    // Other enum values are used during parsing audio streams into cycle kinds
    enum HalfCycleKind
    {
        TooHigh,
        High,
        Indeterminate,
        Low,
        TooLow,
    }

    [StreamKind("half-cycle kind stream", "half-cycle kind stream")]
    interface IHalfCycleKindStream : IStream
    {
        HalfCycleKind GetHalfCycleKind();
        int GetCurrentBaudRate();
    }
}
