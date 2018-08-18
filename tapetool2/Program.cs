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
        const int verMinor = 1;

        static void ShowLogo()
        {
            // Show some help
            Console.WriteLine("tapetool2 v{0}.{1} - Microbee/Sorcerer Tape Diagnotic Utility", verMajor, verMinor);
            Console.WriteLine("Copyright (C) 2017-2018 Topten Software.\n");
        }

        static void ShowUsage()
        {
            Console.WriteLine("Usage: tapetool2 [filters...]");

            Console.WriteLine("\nSupported Filters:");
            foreach (var i in FilterInfo.SupportedFilters)
            {
                Console.Write("  {0,-30} {1}", i.Name, i.Description);
                if (!string.IsNullOrEmpty(i.Attributes.FileExtension))
                {
                    Console.Write(" (*{0} {1})", i.Attributes.FileExtension, i.Attributes.IsFileReader ? "reader" : "writer");
                }
                Console.WriteLine();
            }

            Console.WriteLine("\nOptions:");
            Console.WriteLine("  {0,-30} {1}", "-h | --help", "Show these usage instructions, or use after filter name for help on that filter");
            Console.WriteLine("  {0,-30} {1}", "-v | --version", "Show version number");

            foreach (var ns in FilterInfo.Namespaces)
            {
                var inheritedNamespaces = FilterInfo.GetInheritedNamespaces(ns).ToList();
                inheritedNamespaces.Insert(0, ns);
                Console.WriteLine("  {0,-30} {1} {2}", 
                    string.Format("--{0}", ns), 
                    string.Format("Use filters"), 
                    string.Join(", ", inheritedNamespaces.Select(x=>string.Format("'{0}.*'", x))));
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

                Console.WriteLine("  {0,-30} {1}", "--" + attr.Name + ":val", attr.Description);
            }

            Console.WriteLine();
        }

        static void ShowChain(IStream stm)
        {
            foreach (var inp in stm.EnumStreams().Where(x=>x != null))
                ShowChain(inp);

            stm.WriteSummary(Console.Out);
            Console.WriteLine();
        }

        static bool SetArgument(IStream stopPos, IStream stm, string name, string value)
        {
            if (stm == stopPos)
                return false;

            if (stm.SetArgument(name, value))
                return true;

            bool handled = false;
            foreach (var p in stm.EnumStreams())
            {
                if (SetArgument(stopPos, p, name, value))
                    handled |= true;
            }

            return handled;
        }

        static IStream nextToLastStream;
        static IStream lastStream;
        static IStream firstStream;
        static bool showFilterHelp;
        static List<string> _usingNamespaces = new List<string>();

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
                    if (SetArgument(nextToLastStream, lastStream, SwitchName, Value))
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
                    _usingNamespaces.Add(SwitchName);
                    _usingNamespaces.AddRange(FilterInfo.GetInheritedNamespaces(SwitchName));
                    return;
                }

                throw new InvalidOperationException(string.Format("Unknown or inapplicable switch: {0}", SwitchName));
            }
            else
            {
                IStream nextStream = null;

                // Try creating a file stream first
                nextStream = FilterInfo.CreateFileStream(arg, lastStream, _usingNamespaces);

                // If failed look for a filter
                if (nextStream == null)
                {
                    // Find filter info
                    var fi = FilterInfo.FindByName(arg);
                    if (fi == null)
                    {
                        // Scan using namespaces
                        foreach (var ns in _usingNamespaces)
                        {
                            fi = FilterInfo.FindByName(string.Format("{0}.{1}", ns, arg));
                            if (fi != null)
                                break;
                        }
                    }

                    if (fi == null)
                        throw new InvalidOperationException(string.Format("Unknown filter type: {0}", arg));

                    // Create instance
                    nextStream = (IStream)Activator.CreateInstance(fi.Type);
                }

                // Connect
                nextStream.SetInput(lastStream, _usingNamespaces);

                // Remember the last user generated stream
                nextToLastStream = lastStream;
                
                // Update chain
                lastStream = nextStream;
                if (firstStream == null)
                    firstStream = lastStream;
            }
        }

        static int Main(string[] args)
        {
            try
            {
                // Microbee namespace also includes all of Kansas
                //FilterInfo.RegisterInheritedNamespace("microbee", "kansas");
                //FilterInfo.RegisterInheritedNamespace("sorcerer", "kansas");

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

                try
                {
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
                }
                finally
                {
                    ShowChain(lastStream);
                }

                return 0;
            }
            catch (Exception x)
            {
                Console.WriteLine();
                Console.WriteLine("*** {0} ***", x.Message);

                if (System.Diagnostics.Debugger.IsAttached)
                    throw;

                return 7;
            }
        }
    }
}
