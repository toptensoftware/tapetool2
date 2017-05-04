using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [AttributeUsage(AttributeTargets.Property)]
    public class SourceAttribute : Attribute
    {
        public SourceAttribute()
        {
        }
    }
}
