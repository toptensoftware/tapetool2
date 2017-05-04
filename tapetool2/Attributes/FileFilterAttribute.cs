using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [AttributeUsage(AttributeTargets.Class)]
    public class FileFilterAttribute : FilterAttribute
    {
        public FileFilterAttribute(string name, string description, string extension, string fileTypeName) : base(name, description)
        {
            Extension = extension;
            FileTypeName = fileTypeName;
        }

        public string Extension
        {
            get;
            private set;
        }

        public string FileTypeName
        {
            get;
            private set;
        }

    }
}
