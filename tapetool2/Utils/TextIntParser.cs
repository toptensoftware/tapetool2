using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    class TextIntParser
    {
        public TextIntParser(TextReader input)
        {
            _input = input;
        }

        TextReader _input;

        public int? Next()
        {
            while (true)
            {
                // Read character
                int chint = _input.Read();

                // Quit if EOF
                if (chint == -1)
                    return null;

                char ch = (char)chint;

                // Ignore white space
                if (char.IsWhiteSpace(ch))
                    continue;

                // Ignore line comments
                if (ch == ';')
                {
                    _input.ReadLine();
                    continue;
                }

                // Ignore block comments
                if (ch == '[')
                {
                    while (true)
                    {
                        chint = _input.Read();
                        if (chint < 0)
                            return '\0';
                        if ((char)chint == ']')
                            break;
                    }
                    continue;
                }

                if (ch >= '0' && ch <= '9')
                {
                    int val = ch - '0';
                    while (true)
                    {
                        chint = _input.Peek();
                        if (chint < 0)
                            break;

                        ch = (char)chint;
                        if (ch >= '0' && ch <= '9')
                        {
                            // Consume it
                            _input.Read();

                            val = val * 10 + (ch - '0');
                        }
                        else
                        {
                            break;
                        }
                    }

                    return val;
                }
                else
                {
                    throw new InvalidDataException("Unexpected characters in integer input stream");
                }
            }
        }
    }
}
