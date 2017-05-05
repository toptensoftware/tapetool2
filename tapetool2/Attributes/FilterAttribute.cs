using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [AttributeUsage(AttributeTargets.Class)]
    public class FilterAttribute : Attribute
    {
        public FilterAttribute(string name, string description)
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
