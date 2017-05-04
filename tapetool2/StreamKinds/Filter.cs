using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    abstract class Filter : IDisposable
    {
        public Filter()
        {
        }


        public T ConvertTo<T>() where T : Filter
        {
            return (T)ConvertTo(typeof(T));
        }

        public virtual Filter ConvertTo(Type filterType)
        {
            return null;
        }


        public virtual void Rewind()
        {
            // Rewind input filter too
            foreach (var x in GetPrecedents())
                x.Rewind();
        }

        public virtual T UpstreamOfType<T>() where T:class
        {
            foreach (var p in GetPrecedents())
            {
                // Is it correct type?
                T pT = p as T;
                if (pT != null)
                    return pT;

                pT = p.UpstreamOfType<T>();
                if (pT != null)
                    return pT;
            }

            return null;
        }

        public abstract IEnumerable<Filter> GetPrecedents();

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
