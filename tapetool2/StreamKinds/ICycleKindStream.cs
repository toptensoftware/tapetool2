using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    // When parsing/generating cassette tape audio
    // cycles are of two frequencies - High and Low
    // For Microbee High Freq = 2400Hz, Low = 1200Hz
    // Other enum values are used during parsing audio streams into cycle kinds
    enum CycleKind
    {
        TooHigh,
        High,
        Indeterminate,
        Low,
        TooLow,
    }

    interface IBaudRateProvider
    {
        int BaudRate { get; }
    }

    interface ISetUpstreamBaudRate
    {
        void SetUpstreamBaudRate(int baudRate);
    }


    [StreamKind("cycle kind stream", "cycle kind stream")]
    interface ICycleKindStream : IStream
    {
        CycleKind GetCycleKind();
        int GetCurrentBaudRate();
    }
}
