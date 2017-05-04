using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    class FileTypeInfo
    {
        public FileTypeInfo(string extension, string fileTypeName)
        {
            Extension = extension;
            FileTypeName = fileTypeName;
        }

        public string Extension
        {
            get;
            private set;
        }

        public string FileTypeName
        {
            get;
            private set;
        }

        public Type ReaderClass
        {
            get;
            private set;
        }

        public Type WriterClass
        {
            get;
            private set;
        }

        public string Capabilities
        {
            get
            {
                if (ReaderClass != null && WriterClass != null)
                    return "read-write";
                if (ReaderClass != null)
                    return "read-only";
                if (WriterClass != null)
                    return "write-only";

                return "N/a";
            }
        }


        static Dictionary<string, FileTypeInfo> _all = new Dictionary<string, FileTypeInfo>(StringComparer.InvariantCultureIgnoreCase);

        static FileTypeInfo()
        {
            foreach (var t in typeof(Program).Assembly.DefinedTypes.Where(x => x.IsClass))
            {
                var attr = t.GetCustomAttributes(typeof(FileFilterAttribute), false).Cast<FileFilterAttribute>().SingleOrDefault();
                if (attr == null)
                    continue;

                FileTypeInfo info;
                if (!_all.TryGetValue(attr.Extension, out info))
                {
                    info = new FileTypeInfo(attr.Extension, attr.FileTypeName);
                    _all.Add(attr.Extension, info);
                }

                if (attr is FileWriterAttribute)
                    info.WriterClass = t;
                if (attr is FileReaderAttribute)
                    info.ReaderClass = t;
            }
        }

        public static IEnumerable<FileTypeInfo> SupportedFileTypes
        {
            get { return _all.Values.OrderBy(x => x.Extension); }
        }

        public static FileTypeInfo FromExtension(string extension)
        {
            FileTypeInfo info;
            if (!_all.TryGetValue(extension, out info))
                return null;

            return info;
        }
    }
}
