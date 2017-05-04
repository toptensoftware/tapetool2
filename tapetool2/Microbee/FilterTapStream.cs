using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Microbee
{
    [StreamKind("Microbee tap stream", "Microbee tap stream")]
    abstract class FilterTapStream : FilterByteStream
    {
        public abstract TapeHeader Header
        {
            get;
        }
    }
}
