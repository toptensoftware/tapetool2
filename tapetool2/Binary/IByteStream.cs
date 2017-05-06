using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Binary
{
    [StreamKind("byte stream", "byte stream")]
    interface IByteStream : IStream
    {
        byte GetByte();
    }
}
