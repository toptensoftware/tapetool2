using System;
using System.Collections.Generic;
using System.IO;
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

        public long Position
        {
            get { return _position; }
        }

        public virtual void SetInput(IStream input, List<string> conversionNamespace)
        {
            // Find the intput property
            var prop = GetType().GetProperties().FirstOrDefault(x => x.GetCustomAttributes(true).OfType<InputStreamAttribute>().Any());

            if (input != null)
            {
                if (prop == null)
                    throw new InvalidOperationException(string.Format("{0} doesn't have a source property and must be the first in the chain", GetType().Name));

                if (!prop.PropertyType.IsAssignableFrom(input.GetType()))
                {
                    var converted = StreamConversion.ConvertStream(input, prop.PropertyType, GetType(), conversionNamespace);
                    if (converted == null)
                    {
                        var namespaces = StreamConversion.FindPossibleConversionNamespaces(input.GetType(), prop.PropertyType, GetType());
                        var suggestion = string.Join(" or ", namespaces.Select(x => "--" + x ));
                        if (suggestion.Length > 0)
                        {
                            suggestion = ".\n\nAn automatic conversion is available if " + suggestion + " is specified before the target stream";
                        }

                        throw new InvalidOperationException(string.Format("{0} can't accept an input of type {1} (expects {2}){3}", GetType().Name, input.GetType().Name, prop.PropertyType.Name, suggestion));
                    }
                    input = converted;
                }

                // Assign it
                prop.SetValue(this, input);
            }
        }

        public virtual IStream ConvertTo(Type filterType)
        {
            return null;
        }


        long _position;
        bool _eof;

        public virtual void Rewind()
        {
            // Rewind input filter too
            foreach (var x in EnumStreams())
            {
                if (x == null)
                    throw new InvalidOperationException(string.Format("Filter {0} has no input stream", GetType().Name));

                x.Rewind();
            }
            _position = -1;
            _eof = false;
        }

        public virtual IStream UpstreamOfType(Type t)
        {
            foreach (var p in EnumStreams().Where(x => x != null))
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

        public abstract IEnumerable<IStream> EnumStreams();

        public virtual bool Next()
        {
            if (_eof)
                return false;

            if (OnNext())
            {
                _position++;
                return true;
            }
            else
            {
                _position++;
                _eof = true;
                return false;
            }
        }

        protected abstract bool OnNext();

        public virtual void Dispose()
        {
            // Also dispose source
            foreach (var x in EnumStreams().Where(x =>x != null))
                x.Dispose();
        }

        public bool SetArgument(string name, string value)
        {
            var opts = GetOptions();

            // Find the property using the name supplied in the attributes
            var prop = GetType().GetProperties().FirstOrDefault( x => {
                var a = x.GetCustomAttribute<FilterOptionAttribute>();
                if (a == null)
                    return false;
                return string.Compare(a.Name, name, true) == 0;
            });
            if (prop == null)
                return false;

            // Must have a attribute to assign it
            var attr = prop.GetCustomAttribute<FilterOptionAttribute>();

            // Qualify file names
            if (attr.IsFileName)
                value = System.IO.Path.GetFullPath(value);

            // Convert string to correct type
            object typedValue;
            if (value == null && prop.PropertyType == typeof(bool))
                typedValue = true;
            else
            {
                if (prop.PropertyType == typeof(ushort) && value.StartsWith("0x"))
                {
                    typedValue = Convert.ToUInt16(value.Substring(2), 16);
                }
                else if (prop.PropertyType == typeof(char) && value.StartsWith("0x"))
                {
                    typedValue = (char)Convert.ToUInt16(value.Substring(2), 16);
                }
                else if (prop.PropertyType.IsEnum)
                {
                    typedValue = Enum.Parse(prop.PropertyType, value);
                }
                else
                {
                    typedValue = Convert.ChangeType(value, prop.PropertyType);
                }
            }

            // Set it
            prop.SetValue(this, typedValue);
            return true;
        }

        public IEnumerable<FilterOptionAttribute> GetOptions()
        {
            foreach (var p in GetType().GetProperties())
            {
                // Get command arguments
                var attr = p.GetCustomAttribute<FilterOptionAttribute>();
                if (attr != null)
                    yield return attr;
            }
        }

        public virtual void WriteSummary(TextWriter w)
        {
            w.Write("{0}", FilterInfo.NameOfFilter(this as IStream));

            // Show filename
            var attr = GetType().GetCustomAttribute<FilterAttribute>();
            if (attr!=null && attr.IsFileReader || attr.IsFileWriter)
            {
                var prop = GetType().GetProperty("Filename");
                w.Write(": {0}", System.IO.Path.GetFileName((string)prop.GetValue(this)));
            }

            w.WriteLine();
            w.WriteLine("    position: {0}{1}", _position, _eof ? " (EOF)" : "");
        }

    }
}
