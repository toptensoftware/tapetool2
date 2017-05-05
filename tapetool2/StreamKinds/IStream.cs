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

        // Get the default input stream for this stream
        void SetInput(IStream stream);
        IEnumerable<IStream> GetInputs();

        // Get an upstream stream of a particular type
        IStream UpstreamOfType(Type filterType);

        // Set an argument on the stream
        bool SetArgument(string name, string value);

        // Get all options for this stream/filter
        IEnumerable<FilterOptionAttribute> GetOptions();
    }
}
