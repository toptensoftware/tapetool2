using System;
using System.Collections.Generic;

namespace tapetool2
{
    class CompositeStream
    {
        public CompositeStream()
        {
        }

        public void Add(IStream stream)
        {
            // Connect chain
            if (_chain.Count > 0)
            {
                stream.SetSource(_chain[_chain.Count - 1]);
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

        public virtual IStream ConvertTo(Type filterType)
        {
            return Last.ConvertTo(filterType);
        }

        public virtual IStream UpstreamOfType(Type filterType)
        {
            return Last.UpstreamOfType(filterType);
        }

        public virtual bool SetArgument(string name, string value)
        {
            for (int i = _chain.Count - 1; i >= 0; i--)
            {
                if (_chain[i].SetArgument(name, value))
                    return true;
            }
            return false;
        }

        public virtual void Dispose()
        {
            Last.Dispose();
        }

    }

}
