using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [AttributeUsage(AttributeTargets.Class|AttributeTargets.Interface)]
    public class StreamKindAttribute : Attribute
    {
        public StreamKindAttribute(string name, string description)
        {
            Name = name;
            Description = description;
        }

        public string Name
        {
            get;
            private set;
        }

        public string Description
        {
            get;
            private set;
        }
    }
}
