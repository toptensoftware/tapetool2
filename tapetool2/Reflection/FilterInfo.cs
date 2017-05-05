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

        public string Description
        {
            get { return _attr.Description; }
        }

        public Type Type
        {
            get { return _type; }
        }

        public bool IsFileFilter
        {
            get { return _attr is FileFilterAttribute; }
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
    }
}
