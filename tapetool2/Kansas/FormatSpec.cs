using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Kansas
{
    class FormatSpec
    {
        Dictionary<int, BaudSpec> _baudSpecs = new Dictionary<int, BaudSpec>();

        public FormatSpec(params BaudSpec[] specs)
        {
            foreach (var s in specs)
            {
                _baudSpecs.Add(s.BaudRate, s);
            }
        }

        public BaudSpec GetBaudSpec(int baudRate)
        {
            BaudSpec spec;
            if (_baudSpecs.TryGetValue(baudRate, out spec))
                return spec;

            throw new InvalidOperationException(string.Format("Unsupported baud rate: {0}", baudRate));
        }

        public static FormatSpec KansasCity = new FormatSpec(
            BaudSpec.KansasCityBaud300,
            BaudSpec.KansasCityBaud1200
            );

        public static FormatSpec Sorcerer = new FormatSpec(
            BaudSpec.KansasCityBaud300,
            BaudSpec.SorcererBaud1200
            );
    }
}
