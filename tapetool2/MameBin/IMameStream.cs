using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.MameBin
{
    [StreamKind("MAME quick load bin stream", "MAME quick load bin stream")]
    interface IMameStream : IStream
    {
        MameHeader Header
        {
            get;
        }

        byte GetByte();
    }
}
