using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    public static class CustomAttributeExtensions
    {
        public static T GetCustomAttribute<T>(this PropertyInfo This)
        {
            var attr = This.GetCustomAttributes(typeof(T), true).SingleOrDefault();
            return (T)attr;
        }
        public static T GetCustomAttribute<T>(this MethodInfo This)
        {
            var attr = This.GetCustomAttributes(typeof(T), true).SingleOrDefault();
            return (T)attr;
        }
        public static T GetCustomAttribute<T>(this Type This)
        {
            var attr = This.GetCustomAttributes(typeof(T), true).SingleOrDefault();
            return (T)attr;
        }
    }
}
