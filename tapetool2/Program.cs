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
            Console.WriteLine("tapetool22 v{0}.{1} - Microbee/TRS-80 Tape Diagnotic Utility", verMajor, verMinor);
            Console.WriteLine("Copyright (C) 2017 Topten Software.\n");
        }

        static void ShowUsage()
        {
            Console.WriteLine("Usage: tapetool22 [filters...]");

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

            Console.WriteLine("\n");
        }

        static string StreamKind(Type t)
        {
            var srcInfo = t.GetCustomAttributes(true).OfType<StreamKindAttribute>().FirstOrDefault();
            if (srcInfo != null)
                return srcInfo.Name;
            else
                return t.Name;

        }

        static void ShowFilterHelp(Filter filter)
        {
            // Get the filter info
            FilterInfo fi = FilterInfo.SupportedFilters.FirstOrDefault(x => x.Type == filter.GetType());

            Console.WriteLine("{0} - {1}", fi.Name, fi.Description);

            // Find the source property
            var sourceProp = fi.Type.GetProperties().FirstOrDefault(x => x.GetCustomAttributes(true).OfType<SourceAttribute>().Any());
            Console.WriteLine("\nInput Kind: {0}", sourceProp == null ? "none" : StreamKind(sourceProp.PropertyType));
            Console.WriteLine("Output Kind: {0}", StreamKind(fi.Type));


            bool firstArg = true;
            foreach (var p in fi.Type.GetProperties())
            {
                // Get command arguments
                var attr = p.GetCustomAttributes(true).OfType<FilterOptionAttribute>().FirstOrDefault();
                if (attr == null)
                    continue;

                if (firstArg)
                {
                    Console.WriteLine("\nOptions:");
                    firstArg = false;
                }

                Console.WriteLine("  {0,-27} {1}", "--" + attr.Name + ":val", attr.Description);
            }

            Console.WriteLine();
        }

        static FilterAudio ConvertToAudio(Filter other)
        {
            // Already audio?
            if (other is FilterAudio)
                return (FilterAudio)other;

            throw new InvalidOperationException(string.Format("Don't know how to convert from {0} to audio", other.GetType().Name));
        }

        public static void SetFileName(Filter filter, string filename)
        {
            // Find the filename property
            var prop = filter.GetType().GetProperties().FirstOrDefault(x => x.Name == "Filename");
            if (prop == null)
                throw new InvalidOperationException("Filter doesn't support Filename property??");

            // Set it
            prop.SetValue(filter, filename);
        }

        public static void SetSource(Filter filter, Filter source)
        {
            // Find the source property
            var prop = filter.GetType().GetProperties().FirstOrDefault(x => x.GetCustomAttributes(true).OfType<SourceAttribute>().Any());

            if (source != null)
            {
                if (prop == null)
                    throw new InvalidOperationException(string.Format("{0} doesn't have a source property and must be the first in the chain", filter.GetType().Name));

                if (prop.PropertyType == typeof(FilterAudio))
                {
                    source = ConvertToAudio(source);
                }

                if (!prop.PropertyType.IsAssignableFrom(source.GetType()))
                {
                    throw new InvalidOperationException(string.Format("{0} can't accept an input of type {1} (expects {2})", filter.GetType().Name, source.GetType().Name, prop.PropertyType.Name));
                }

                // Assign it
                prop.SetValue(filter, source);
            }
        }

        static Filter lhsFilter;
        static Filter firstFilter;
        static bool showFilterHelp;

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
                if (lhsFilter != null)
                {
                    if (lhsFilter.SetArgument(SwitchName, Value))
                        return;
                }

                // Other switches?
                switch (SwitchName.ToLower())
                {
                    case "h":
                    case "help":
                        if (lhsFilter != null)
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
            }
            else
            {
                Filter nextFilter;

                // Is it a file name?
                var rdot = arg.LastIndexOf('.');
                if (rdot >= 0)
                {
                    var ext = arg.Substring(rdot + 1);
                    var fti = FileTypeInfo.FromExtension(ext);
                    if (fti == null)
                    {
                        throw new InvalidOperationException(string.Format("Unsupported file type: {0}", ext));
                    }

                    if (lhsFilter == null)
                    {
                        if (fti.ReaderClass == null)
                            throw new InvalidOperationException(string.Format("Reading {0} files not supported", ext));

                        nextFilter = (Filter)Activator.CreateInstance(fti.ReaderClass);
                    }
                    else
                    {
                        if (fti.WriterClass == null)
                            throw new InvalidOperationException(string.Format("Writing {0} files not supported", ext));

                        nextFilter = (Filter)Activator.CreateInstance(fti.WriterClass);
                    }

                    // Set the filename of the file reader/writer
                    SetFileName(nextFilter, System.IO.Path.GetFullPath(arg));
                }
                else
                {
                    // Find filter info
                    var fi = FilterInfo.FindByName(arg);
                    if (fi == null)
                    {
                        throw new InvalidOperationException(string.Format("Unknown filter type: {0}", arg));
                    }

                    /*
                    // Asking for help?
                    if (i + 1 < args.Length)
                    {
                        if (args[i+1] == "-h" || args[i+1] == "--help")
                        {
                            ShowFilterHelp(fi);
                            return 0;
                        }
                    }
                    */

                    // Create instance
                    nextFilter = (Filter)Activator.CreateInstance(fi.Type);
                }

                SetSource(nextFilter, lhsFilter);
                lhsFilter = nextFilter;
                if (firstFilter == null)
                    firstFilter = lhsFilter;
            }
        }

        static int Main(string[] args)
        {
            lhsFilter = null;

            for (int i=0; i < args.Length; i++)
            {
                ProcessArg(args[i]);
            }

            // Show help for the first filter?
            if (showFilterHelp)
            {
                ShowLogo();
                ShowFilterHelp(firstFilter);
                return 0;
            }

            // Nothing to do?
            if (lhsFilter == null)
            {
                ShowLogo();
                ShowUsage();
                return 0;
            }

            // Dispose filters
            lhsFilter.Rewind();

            // Process filter until done
            while (lhsFilter.Next())
            {
                // nop
            }

            // Dispose filters
            lhsFilter.Dispose();

            return 0;
        }
    }

    /*
    tapReader -> tapeByteStream -> byteToCycleGenerator -> cycleToBitStream -> bitStreamToAudio -> waveFile
                                                                            -> tbsFile
              -> tapeDataParser -> byteStream -> binFile
    */
}
