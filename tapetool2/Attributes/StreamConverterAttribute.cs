using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [AttributeUsage(AttributeTargets.Method)]
    public class StreamConverterAttribute : Attribute
    {
        public StreamConverterAttribute()
        {
        }

        public Type TargetObjectType
        {
            get;
            set;
        }

        public string Namespace
        {
            get;
            set;
        }
    }
}
