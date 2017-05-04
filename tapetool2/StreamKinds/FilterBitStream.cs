using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [StreamKind("bit stream", "bit stream")]
    abstract class FilterBitStream: Filter
    {
        public abstract bool GetSample();
    }
}
