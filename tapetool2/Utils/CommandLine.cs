using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    static class CommandLine
    {
        public static List<string> Parse(string args)
        {
            var newargs = new List<string>();

            var temp = new StringBuilder();

            int i = 0;
            while (i < args.Length)
            {
                if (char.IsWhiteSpace(args[i]))
                {
                    i++;
                    continue;
                }

                bool bInQuotes = false;
                temp.Length = 0;
                while (i < args.Length && (!char.IsWhiteSpace(args[i]) && !bInQuotes))
                {
                    if (args[i] == '\"')
                    {
                        if (args[i + 1] == '\"')
                        {
                            temp.Append("\"");
                            i++;
                        }
                        else
                        {
                            bInQuotes = !bInQuotes;
                        }
                    }
                    else
                    {
                        temp.Append(args[i]);
                    }

                    i++;
                }

                if (temp.Length > 0)
                {
                    newargs.Add(temp.ToString());
                }
            }

            return newargs;
        }
    }
}
