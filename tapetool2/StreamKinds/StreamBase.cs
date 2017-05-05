using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    abstract class StreamBase : IDisposable
    {
        public StreamBase()
        {
        }


        public virtual IStream ConvertTo(Type filterType)
        {
            return null;
        }


        public virtual void Rewind()
        {
            // Rewind input filter too
            foreach (var x in GetPrecedents())
                x.Rewind();
        }

        public virtual IStream UpstreamOfType(Type t)
        {
            foreach (var p in GetPrecedents())
            {
                if (t.IsAssignableFrom(p.GetType()))
                    return p;

                var u = p.UpstreamOfType(t);
                if (u != null)
                    return u;
            }

            return null;
        }

        public T UpstreamOfType<T>() where T : class
        {
            var us = UpstreamOfType(typeof(T));
            return (T)us;
        }

        public abstract IEnumerable<IStream> GetPrecedents();

        public abstract bool Next();

        public virtual void Dispose()
        {
            // Also dispose source
            foreach (var x in GetPrecedents())
                x.Dispose();
        }

        public bool SetArgument(string name, string value)
        {
            // Find the property
            var prop = GetType().GetProperties().FirstOrDefault(x => string.Compare(x.Name, name, true) == 0);
            if (prop == null)
                return false;

            // Must have a attribute to assign it
            var attr = prop.GetCustomAttributes(typeof(FilterOptionAttribute), true).Cast<FilterOptionAttribute>().FirstOrDefault();
            if (attr == null)
                return false;

            // Qualify file names
            if (attr.IsFileName)
                value = System.IO.Path.GetFullPath(value);

            // Convert string to correct type
            var typedValue = Convert.ChangeType(value, prop.PropertyType);

            // Set it
            prop.SetValue(this, typedValue);
            return true;
        }

    }
}
