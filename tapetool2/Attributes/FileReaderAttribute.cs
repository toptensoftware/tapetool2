using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [AttributeUsage(AttributeTargets.Class)]
    public class FileReaderAttribute : FileFilterAttribute
    {
        public FileReaderAttribute(string name, string description, string extension, string fileTypeName) : base(name, description, extension, fileTypeName)
        {
        }

    }
}
