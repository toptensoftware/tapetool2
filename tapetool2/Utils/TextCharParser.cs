using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    class TextCharParser
    {
        public TextCharParser(TextReader input)
        {
            _input = input;
        }

        TextReader _input;

        public char Next()
        {
            while (true)
            {
                // Read character
                int chint = _input.Read();

                // Quit if EOF
                if (chint == -1)
                    return '\0';

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

                return ch;
            }
        }
    }
}
