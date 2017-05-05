using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    static class StreamConversion
    {
        static List<MethodInfo> _conversionMethods;

        public static T ConvertStream<T>(IStream stream, Type targetObjectType, string nameSpace) where T : IStream
        {
            return (T)ConvertStream(stream, typeof(T), targetObjectType, nameSpace);
        }

        public static IStream ConvertStream(IStream stream, Type to, Type targetObjectType, string nameSpace)
        {
            // Find best method
            var mi = FindConversionMethod(stream.GetType(), to, targetObjectType, nameSpace);
            if (mi == null)
                return null;

            // Invoke it
            return (IStream)mi.Invoke(null, new object[] { stream });
        }

        public static IEnumerable<string> FindPossibleConversionNamespaces(Type from, Type to, Type targetObjectType)
        {
            return FindConversionMethods(from, to, targetObjectType, "*").Select(x =>
            {
                var attr = x.GetCustomAttribute<StreamConverterAttribute>();
                if (attr != null && attr.Namespace != null)
                    return attr.Namespace;
                return null;
            }).Where(x=>x!=null).Distinct();
        }

        public static IEnumerable<MethodInfo> FindConversionMethods(Type from, Type to, Type targetObjectType, string nameSpace)
        {
            if (_conversionMethods == null)
            {
                // Build a list of all available conversion methods
                _conversionMethods = typeof(Program).Assembly
                        .GetTypes()
                        .Where(x => x.IsClass)
                        .SelectMany(t => t.GetMethods().Where(x => x.IsStatic && x.GetCustomAttribute<StreamConverterAttribute>() != null && x.GetParameters().Length == 1))
                        .ToList();
            }

            return _conversionMethods.Where(x => {
                var attr = x.GetCustomAttribute<StreamConverterAttribute>();

                // Target object type must also match (if supplied)
                if (attr.TargetObjectType != null && attr.TargetObjectType != targetObjectType)
                    return false;

                // Namespace must match
                if (nameSpace != "*")
                {
                    if (attr.Namespace != null && string.Compare(attr.Namespace, nameSpace, true) != 0)
                        return false;
                }

                return true;
            });
        }

        public static MethodInfo FindConversionMethod(Type from, Type to, Type targetObjectType, string nameSpace)
        {
            var methods = FindConversionMethods(from, to, targetObjectType, nameSpace);

            // Look for exact match
            foreach (var m in methods)
            {
                if (m.GetParameters()[0].ParameterType == from && m.ReturnType == to)
                    return m;
            }

            // Look for exact target type, any from type
            foreach (var m in methods)
            {
                if (m.GetParameters()[0].ParameterType.IsAssignableFrom(from) && m.ReturnType == to)
                    return m;
            }

            // Look for any compatible conversion
            foreach (var m in methods)
            {
                if (m.GetParameters()[0].ParameterType.IsAssignableFrom(from) && to.IsAssignableFrom(m.ReturnType))
                    return m;
            }

            // Not found!
            return null;
        }

    }
}
