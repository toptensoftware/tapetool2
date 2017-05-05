using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    static class IStreamExtensions
    {
        public static void SetSource(this IStream target, IStream source)
        {
            // Find the source property
            var prop = target.GetType().GetProperties().FirstOrDefault(x => x.GetCustomAttributes(true).OfType<SourceAttribute>().Any());

            if (source != null)
            {
                if (prop == null)
                    throw new InvalidOperationException(string.Format("{0} doesn't have a source property and must be the first in the chain", target.GetType().Name));

                if (!prop.PropertyType.IsAssignableFrom(source.GetType()))
                {
                    var converted = source.ConvertTo(prop.PropertyType);
                    if (converted == null)
                        throw new InvalidOperationException(string.Format("{0} can't accept an input of type {1} (expects {2})", target.GetType().Name, source.GetType().Name, prop.PropertyType.Name));
                }

                // Assign it
                prop.SetValue(target, source);
            }
        }

    }
}
