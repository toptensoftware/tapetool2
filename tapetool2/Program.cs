using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    class Program
    {
        const int verMajor = 1;
        const int verMinor = 0;

        static void ShowLogo()
        {
            // Show some help
            Console.WriteLine("tapetool2 v{0}.{1} - Microbee/TRS-80 Tape Diagnotic Utility", verMajor, verMinor);
            Console.WriteLine("Copyright (C) 2017 Topten Software.\n");
        }

        static void ShowUsage()
        {
            Console.WriteLine("Usage: tapetool2 [filters...]");

            Console.WriteLine("\nFile Types:");
            foreach (var i in FileTypeInfo.SupportedFileTypes)
            {
                Console.WriteLine("  *.{0,-25} {1} ({2})", i.Extension, i.FileTypeName, i.Capabilities);
            }

            Console.WriteLine("\nFilters:");
            foreach (var i in FilterInfo.SupportedFilters)
            {
                Console.WriteLine("  {0,-27} {1}", i.Name, i.Description);

            }

            Console.WriteLine("\nOptions:");
            Console.WriteLine("  {0,-27} {1}", "-h | --help", "Show these usage instructions, or use after command name for help on that command");
            Console.WriteLine("  {0,-27} {1}", "-v | --version", "Show version number");

            foreach (var ns in FilterInfo.Namespaces)
            {
                Console.WriteLine("  {0,-27} {1}", string.Format("--{0}", ns), string.Format("Use namespace '{0}'", ns));
            }

            Console.WriteLine("\n");
        }

        static string StreamKind(Type t)
        {
            // If it's a class we really want to find it's stream interface
            if (t.IsClass)
            {
                var itf = t.GetInterfaces().FirstOrDefault(x => typeof(IStream).IsAssignableFrom(x) && x != typeof(IStream));
                if (itf != null)
                    t = itf;
            }

            var srcInfo = t.GetCustomAttributes(true).OfType<StreamKindAttribute>().FirstOrDefault();
            if (srcInfo != null)
                return srcInfo.Name;
            else
                return t.Name;

        }

        static void ShowFilterHelp(IStream stream)
        {
            // Get the filter info
            FilterInfo fi = FilterInfo.SupportedFilters.FirstOrDefault(x => x.Type == stream.GetType());

            Console.WriteLine("{0} - {1}", fi.Name, fi.Description);

            // Find the source property
            var sourceProp = fi.Type.GetProperties().FirstOrDefault(x => x.GetCustomAttributes(true).OfType<InputStreamAttribute>().Any());
            Console.WriteLine("\nInput Kind: {0}", sourceProp == null ? "none" : StreamKind(sourceProp.PropertyType));
            Console.WriteLine("Output Kind: {0}", StreamKind(fi.Type));

            bool firstArg = true;
            foreach (var attr in stream.GetOptions())
            {
                if (firstArg)
                {
                    Console.WriteLine("\nOptions:");
                    firstArg = false;
                }

                Console.WriteLine("  {0,-27} {1}", "--" + attr.Name + ":val", attr.Description);
            }

            Console.WriteLine();
        }

        public static void SetFileName(IStream stream, string filename)
        {
            // Find the filename property
            var prop = stream.GetType().GetProperties().FirstOrDefault(x => x.Name == "Filename");
            if (prop == null)
                throw new InvalidOperationException("Filter doesn't support Filename property??");

            // Set it
            prop.SetValue(stream, filename);
        }

        static void ShowChain(IStream stm)
        {
            foreach (var inp in stm.GetInputs())
                ShowChain(inp);
            Console.WriteLine("{0}", FilterInfo.NameOfFilter(stm));
        }


        static IStream lastStream;
        static IStream firstStream;
        static bool showFilterHelp;
        static string _currentNamespace;

        static void ProcessArg(string arg)
        {
            // Response file
            if (arg.StartsWith("@"))
            {
                // Get the fully qualified response file name
                string strResponseFile = System.IO.Path.GetFullPath(arg.Substring(1));

                // Load and parse the response file
                var args = CommandLine.Parse(System.IO.File.ReadAllText(strResponseFile));

                // Set the current directory
                string OldCurrentDir = System.IO.Directory.GetCurrentDirectory();
                System.IO.Directory.SetCurrentDirectory(System.IO.Path.GetDirectoryName(strResponseFile));

                // Load the file
                foreach (var a in args)
                {
                    ProcessArg(a);
                }


                // Restore current directory
                System.IO.Directory.SetCurrentDirectory(OldCurrentDir);

                return;
            }


            // Args are in format [/-]<switchname>[:<value>];
            if (arg.StartsWith("/") || arg.StartsWith("-"))
            {
                string SwitchName = arg.Substring(arg.StartsWith("--") ? 2 : 1);
                string Value = null;

                // Is it a switched value?
                int colonpos = SwitchName.IndexOf(':');
                if (colonpos >= 0)
                {
                    // Split it
                    Value = SwitchName.Substring(colonpos + 1);
                    SwitchName = SwitchName.Substring(0, colonpos);
                }

                // Pass to filter?
                if (lastStream != null)
                {
                    if (lastStream.SetArgument(SwitchName, Value))
                        return;
                }

                // Other switches?
                switch (SwitchName.ToLower())
                {
                    case "h":
                    case "help":
                        if (lastStream != null)
                        {
                            showFilterHelp = true;
                        }
                        else
                        {
                            ShowLogo();
                            ShowUsage();
                        }
                        return;

                    case "v":
                    case "version":
                        ShowLogo();
                        return;
                }

                if (FilterInfo.Namespaces.Contains(SwitchName, StringComparer.InvariantCultureIgnoreCase))
                {
                    _currentNamespace = SwitchName;
                }
            }
            else
            {
                IStream nextStream = null;

                // Is it a file name?
                var rdot = arg.LastIndexOf('.');
                if (rdot >= 0)
                {
                    var ext = arg.Substring(rdot + 1);
                    var fti = FileTypeInfo.FromExtension(ext);
                    if (fti == null)
                    {
                        if (FilterInfo.Namespaces.Contains(arg.Substring(0, rdot), StringComparer.InvariantCultureIgnoreCase))
                        {
                            // It might be a filter qualifier and not really a filename
                            // eg: microbee.renderAudio
                        }
                        else   
                            throw new InvalidOperationException(string.Format("Unsupported file type: {0}", ext));
                    }
                    else
                    {
                        if (lastStream == null)
                        {
                            if (fti.ReaderClass == null)
                                throw new InvalidOperationException(string.Format("Reading {0} files not supported", ext));

                            nextStream = (IStream)Activator.CreateInstance(fti.ReaderClass);
                        }
                        else
                        {
                            if (fti.WriterClass == null)
                                throw new InvalidOperationException(string.Format("Writing {0} files not supported", ext));

                            nextStream = (IStream)Activator.CreateInstance(fti.WriterClass);
                        }

                        // Set the filename of the file reader/writer
                        SetFileName(nextStream, System.IO.Path.GetFullPath(arg));
                    }
                }

                if (nextStream == null)
                {
                    // Find filter info
                    var fi = FilterInfo.FindByName(arg);
                    if (fi == null && _currentNamespace != null)
                    {
                        fi = FilterInfo.FindByName(string.Format("{0}.{1}", _currentNamespace, arg));
                    }

                    if (fi == null)
                        throw new InvalidOperationException(string.Format("Unknown filter type: {0}", arg));

                    // Create instance
                    nextStream = (IStream)Activator.CreateInstance(fi.Type);
                }

                nextStream.SetInput(lastStream);
                lastStream = nextStream;
                if (firstStream == null)
                    firstStream = lastStream;
            }
        }

        static int Main(string[] args)
        {
            try
            {
                lastStream = null;
                for (int i=0; i < args.Length; i++)
                {
                    ProcessArg(args[i]);
                }

                // Show help for the first filter?
                if (showFilterHelp)
                {
                    ShowLogo();
                    ShowFilterHelp(firstStream);
                    return 0;
                }

                // Nothing to do?
                if (lastStream == null)
                {
                    ShowLogo();
                    ShowUsage();
                    return 0;
                }

                ShowChain(lastStream);

                using (lastStream)
                {
                    // Dispose filters
                    lastStream.Rewind();

                    // Process filter until done
                    while (lastStream.Next())
                    {
                        // nop
                    }
                }

                return 0;
            }
            catch (Exception x)
            {
                Console.WriteLine();
                Console.WriteLine(x.Message);

                if (System.Diagnostics.Debugger.IsAttached)
                    throw;

                return 7;
            }
        }
    }
}
