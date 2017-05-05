using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    interface IStream : IDisposable
    {
        // Rewind to start of stream
        void Rewind();

        // Move to the next sample
        bool Next();

        // Convert this stream to another type
        IStream ConvertTo(Type filterType);

        // Set an argument
        bool SetArgument(string name, string value);
    }
}
