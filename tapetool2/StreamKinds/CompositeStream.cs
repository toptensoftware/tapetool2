using System;
using System.Collections.Generic;
using System.Linq;

namespace tapetool2
{
    class CompositeStream
    {
        public CompositeStream()
        {
        }

        public virtual void SetInput(IStream input, string conversionNamespace)
        {
            First.SetInput(input, conversionNamespace);
        }

        public virtual IEnumerable<IStream> EnumStreams()
        {
            yield return Last;
        }

        public void Add(IStream stream)
        {
            // Connect chain
            if (_chain.Count > 0)
            {
                stream.SetInput(_chain[_chain.Count - 1], null);
            }

            // Add to list
            _chain.Add(stream);
        }

        List<IStream> _chain = new List<IStream>();

        protected IStream First
        {
            get { return _chain[0]; }
        }

        protected IStream Last
        {
            get { return _chain[_chain.Count - 1]; }
        }

        public virtual void Rewind()
        {
            Last.Rewind();
        }

        public virtual bool Next()
        {
            return Last.Next();
        }

        public virtual IStream UpstreamOfType(Type filterType)
        {
            return Last.UpstreamOfType(filterType);
        }

        public virtual bool SetArgument(string name, string value)
        {
            /*
            for (int i = _chain.Count - 1; i >= 0; i--)
            {
                if (_chain[i].SetArgument(name, value))
                    return true;
            }
            */
            return false;
        }

        public IEnumerable<FilterOptionAttribute> GetOptions()
        {
            return _chain.SelectMany(x => x.GetOptions());
        }

        public virtual void Dispose()
        {
            Last.Dispose();
        }

    }

}
