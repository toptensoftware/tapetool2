using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    public static class Glob
    {
        // Based roughly on this: https://superuser.com/questions/475874/how-does-the-windows-rename-command-interpret-wildcards
        public static string GetTargetFileName(string sourcefile, string targetMask)
        {
            if (string.IsNullOrEmpty(sourcefile))
                throw new ArgumentNullException("sourcefile");

            if (string.IsNullOrEmpty(targetMask))
                throw new ArgumentNullException("targetMask");

            if (sourcefile.Contains('*') || sourcefile.Contains('?'))
                throw new ArgumentException("sourcefile cannot contain wildcards");

            // no wildcards: return complete mask as file
            if (!targetMask.Contains('*') && !targetMask.Contains('?'))
                return targetMask;

            var maskReader = new StringReader(targetMask);
            var sourceReader = new StringReader(sourcefile);
            var targetBuilder = new StringBuilder();


            while (maskReader.Peek() != -1)
            {

                int current = maskReader.Read();
                int sourcePeek = sourceReader.Peek();
                switch (current)
                {
                    case '*':
                        int next = maskReader.Read();
                        switch (next)
                        {
                            case -1:
                            case '?':
                                // Append all remaining characters from sourcefile
                                targetBuilder.Append(sourceReader.ReadToEnd());
                                break;
                            default:
                                // Read source until the last occurrance of 'next'.
                                // We cannot seek in the StringReader, so we will create a new StringReader if needed
                                string sourceTail = sourceReader.ReadToEnd();
                                int lastIndexOf = sourceTail.LastIndexOf((char)next);
                                // If not found, append everything and the 'next' char
                                if (lastIndexOf == -1)
                                {
                                    targetBuilder.Append(sourceTail);
                                    targetBuilder.Append((char)next);

                                }
                                else
                                {
                                    string toAppend = sourceTail.Substring(0, lastIndexOf + 1);
                                    string rest = sourceTail.Substring(lastIndexOf + 1);
                                    sourceReader.Dispose();
                                    // go on with the rest...
                                    sourceReader = new StringReader(rest);
                                    targetBuilder.Append(toAppend);
                                }
                                break;
                        }

                        break;
                    case '?':
                        if (sourcePeek != -1 && sourcePeek != '.')
                        {
                            targetBuilder.Append((char)sourceReader.Read());
                        }
                        break;
                    case '.':
                        // eat all characters until the dot is found
                        while (sourcePeek != -1 && sourcePeek != '.')
                        {
                            sourceReader.Read();
                            sourcePeek = sourceReader.Peek();
                        }

                        targetBuilder.Append('.');
                        // need to eat the . when we peeked it
                        if (sourcePeek == '.')
                            sourceReader.Read();

                        break;
                    default:
                        if (sourcePeek != '.') sourceReader.Read(); // also consume the source's char if not .
                        targetBuilder.Append((char)current);
                        break;
                }

            }

            sourceReader.Dispose();
            maskReader.Dispose();
            return targetBuilder.ToString().TrimEnd('.', ' ');
        }
    }
}
