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

        public static T ConvertStream<T>(IStream stream, Type targetObjectType) where T : IStream
        {
            return (T)ConvertStream(stream, typeof(T), targetObjectType);
        }

        public static IStream ConvertStream(IStream stream, Type to, Type targetObjectType)
        {
            // Find best method
            var mi = FindConversionMethod(stream.GetType(), to, targetObjectType);
            if (mi == null)
                return null;

            // Invoke it
            return (IStream)mi.Invoke(null, new object[] { stream });
        }

        static MethodInfo FindConversionMethod(Type from, Type to, Type targetObjectType)
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

            var methodsFilteredByTargetType = _conversionMethods.Where(x =>
                        x.GetCustomAttribute<StreamConverterAttribute>().TargetObjectType == null ||
                        x.GetCustomAttribute<StreamConverterAttribute>().TargetObjectType == targetObjectType);

            // Look for exact match
            foreach (var m in methodsFilteredByTargetType)
            {
                if (m.GetParameters()[0].ParameterType == from && m.ReturnType == to)
                    return m;
            }

            // Look for exact target type, any from type
            foreach (var m in methodsFilteredByTargetType)
            {
                if (m.GetParameters()[0].ParameterType.IsAssignableFrom(from) && m.ReturnType == to)
                    return m;
            }

            // Look for any compatible conversion
            foreach (var m in methodsFilteredByTargetType)
            {
                if (m.GetParameters()[0].ParameterType.IsAssignableFrom(from) && to.IsAssignableFrom(m.ReturnType))
                    return m;
            }

            // Not found!
            return null;
        }

    }
}
