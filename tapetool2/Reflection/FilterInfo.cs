using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    class FilterInfo
    {
        public FilterInfo(FilterAttribute attr, Type type)
        {
            _attr = attr;
            _type = type;
        }

        FilterAttribute _attr;
        Type _type;

        public string Name
        {
            get { return _attr.Name; }
        }

        public FilterAttribute Attributes
        {
            get { return _attr; }
        }

        public string Description
        {
            get { return _attr.Description; }
        }

        public Type Type
        {
            get { return _type; }
        }

        static public Dictionary<string, FilterInfo> _all = new Dictionary<string, FilterInfo>(StringComparer.InvariantCultureIgnoreCase);

        static FilterInfo()
        {
            foreach (var t in typeof(Program).Assembly.DefinedTypes.Where(x => x.IsClass && !x.IsAbstract))
            {
                var attr = t.GetCustomAttributes(typeof(FilterAttribute), false).Cast<FilterAttribute>().SingleOrDefault();
                if (attr == null)
                    continue;

                FilterInfo info;
                if (!_all.TryGetValue(attr.Name, out info))
                {
                    info = new FilterInfo(attr, t);
                    _all.Add(attr.Name, info);
                }
            }
        }

        public static IEnumerable<FilterInfo> SupportedFilters
        {
            get { return _all.Values.OrderBy(x => x.Name); }
        }

        public static IEnumerable<string> Namespaces
        {
            get
            {
                var namespaces = new HashSet<string>();

                foreach (var i in SupportedFilters)
                {
                    int dotPos = i.Name.IndexOf('.');
                    if (dotPos >= 0)
                    {
                        namespaces.Add(i.Name.Substring(0, dotPos));
                    }
                }

                return namespaces.OrderBy(x => x);
            }
        }

        public static FilterInfo FindByName(string name)
        {
            FilterInfo info;
            if (!_all.TryGetValue(name, out info))
                return null;

            return info;
        }

        public static string NameOfFilter(IStream s)
        {
            var attr = s.GetType().GetCustomAttribute<FilterAttribute>();
            if (attr == null)
                return s.GetType().Name;
            else
                return attr.Name;
        }

        public static FilterInfo ResolveFileTypeFilter(string filename, IStream sourceStream)
        {
            // Look for an appropriate filter
            var contenders = _all.Values.Where(x =>
                x.Attributes.FileExtension != null &&
                filename.EndsWith(x.Attributes.FileExtension, StringComparison.InvariantCultureIgnoreCase) &&
                x.Attributes.IsFileReader == (sourceStream == null)
                ).ToList();

            if (contenders.Count == 0)
            {
                if (FilterInfo.Namespaces.Any(x=>filename.StartsWith(x + ".", StringComparison.InvariantCultureIgnoreCase)))
                {
                    // It might be a filter qualifier and not really a filename
                    // eg: microbee.renderAudio
                    return null;
                }
                else
                    throw new InvalidOperationException(string.Format("Unsupported file type: '{0}'", filename));
            }

            if (contenders.Count == 1)
                return contenders[0];

            // TODO: resolve multiple
            return null;
        }

        public static IStream CreateFileStream(string filename, IStream sourceStream)
        {
            if (filename.IndexOf('.') < 0)
                return null;

            var fti = ResolveFileTypeFilter(filename, sourceStream);
            if (fti == null)
                return null;

            // Set the filename of the file reader/writer
            var filter = (IStream)Activator.CreateInstance(fti.Type);

            // Find the filename property
            var prop = filter.GetType().GetProperties().FirstOrDefault(x => x.Name == "Filename");
            if (prop == null)
                throw new InvalidOperationException("Filter doesn't support Filename property??");

            // Set it
            prop.SetValue(filter, System.IO.Path.GetFullPath(filename));

            return filter;
        }

        public static IStream CreateFileWriter(string filename)
        {
            return null;
        }
    }
}
