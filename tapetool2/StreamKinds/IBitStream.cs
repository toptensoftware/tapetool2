using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [StreamKind("bit stream", "bit stream")]
    interface IBitStream : IStream
    {
        bool GetSample();
    }
}
