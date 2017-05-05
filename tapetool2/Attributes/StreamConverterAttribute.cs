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

        public StreamConverterAttribute(Type targetObjectType)
        {
            TargetObjectType = targetObjectType;
        }

        public Type TargetObjectType
        {
            get; private set;
        }
    }
}
