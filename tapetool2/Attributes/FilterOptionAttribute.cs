using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [AttributeUsage(AttributeTargets.Property)]
    public class FilterOptionAttribute : Attribute
    {
        public FilterOptionAttribute(string name, string description)
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

        // When true command line parser will fully qualify
        // the file name before setting
        public bool IsFileName
        {
            get;
            set;
        }
    }
}
