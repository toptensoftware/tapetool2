using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Tape;

namespace tapetool2.Kansas
{
    class BaudSpec
    {
        public int BaudRate;
        public int ZeroBitHalfCycleCount;
        public HalfCycleKind ZeroBitHalfCycleKind = HalfCycleKind.Low;
        public int OneBitHalfCycleCount;
        public HalfCycleKind OneBitHalfCycleKind = HalfCycleKind.High;
        public int LowFrequency = 1200;
        public bool[] leadBits = new bool[] { false };
        public bool[] tailBits = new bool[] { true, true };

        // https://en.wikipedia.org/wiki/Kansas_City_standard
        public static BaudSpec KansasCityBaud300 = new BaudSpec()
        {
            BaudRate = 300,
            ZeroBitHalfCycleCount = 4 * 2,
            OneBitHalfCycleCount = 8 * 2,
        };

        // https://en.wikipedia.org/wiki/Kansas_City_standard
        public static BaudSpec KansasCityBaud1200 = new BaudSpec()
        {
            BaudRate = 1200,
            ZeroBitHalfCycleCount = 1 * 2,
            OneBitHalfCycleCount = 2 * 2,
        };

        public static BaudSpec SorcererBaud1200 = new BaudSpec()
        {
            BaudRate = 1200,
            ZeroBitHalfCycleCount = 1,
            OneBitHalfCycleCount = 2,
            LowFrequency = 600,
        };
    }
}
