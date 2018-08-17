using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Tape
{
    class HalfCycleLengthDetector
    {
        public HalfCycleLengthDetector()
        {
        }

        // Reset
        public void Reset()
        {
            _samplesSinceLastCrossing = 0;
            _prevSample = 0;
        }

        int _samplesSinceLastCrossing;
        float _prevSample;
        float _noMansLand = 0.01f;

        // Updates current state and returns
        // 0 if no new zero crossing
        // non-0 if zero crossing - indicating the length of the half cycle
        public int Update(float value)
        {
            // Update sample count
            _samplesSinceLastCrossing++;

            // Inside values inside no-mans land
            if (value >= -_noMansLand && value <= _noMansLand)
            {
                return 0;
            }

            // Crossed?
            bool crossed = (_prevSample < 0) != (value < 0);

            // Store the prev sample value
            _prevSample = value;

            // Quit if not a crossing
            if (!crossed)
                return 0;

            // Return the length of the half cycle
            int retv = _samplesSinceLastCrossing;
            _samplesSinceLastCrossing = 0;
            return retv;
        }

        // return length of last cycle
        public int CurrentCycleLength()
        {
            return _samplesSinceLastCrossing;
        }
    }
}
