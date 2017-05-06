using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Tape
{
    public enum CycleLengthMethod
    {
        Auto,
        ZeroCrossingUp,
        ZeroCrossingDown,
        PositiveDutyLength,
        NegativeDutyLength,
    }


    class CycleLengthDetector
    {
        public CycleLengthDetector()
        {
            Method = CycleLengthMethod.ZeroCrossingUp;
        }

        public static CycleLengthMethod ParseMethod(string str)
        {
            switch (str.ToLowerInvariant())
            {
                case "zc+": return CycleLengthMethod.ZeroCrossingUp;
                case "zc-": return CycleLengthMethod.ZeroCrossingDown;
                case "duty+": return CycleLengthMethod.PositiveDutyLength;
                case "duty-": return CycleLengthMethod.PositiveDutyLength;
            }
            throw new InvalidOperationException(string.Format("Invalid cycle length method: '{0}'", str));
        }

        public CycleLengthMethod Method
        {
            get;
            set;
        }

        // Reset
        public void Reset()
        {
            _samplesSinceLastCrossing = 0;
            _prevSample = 0;
        }

        int _samplesSinceLastCrossing;
        int _dutySamples;
        float _dutyCycle;
        float _prevSample;
        float _noMansLand = 0.01f;

        // Updates current state and returns
        // 0 if no new zero crossing
        // non-0 if zero crossing.  Value is number of samples
        // since the last zero crossing.
        public int Update(float value)
        {
            // Update sample count
            _samplesSinceLastCrossing++;

            // Inside values inside no-mans land
            if (value >= -_noMansLand && value <= _noMansLand)
            {
                return 0;
            }


            bool crossedUp = _prevSample < 0 && value > 0;
            bool crossedDown = _prevSample > 0 && value < 0;

            bool crossedFull;
            bool crossedHalf;
            if (Method != CycleLengthMethod.ZeroCrossingDown)
            {
                crossedFull = crossedUp;
                crossedHalf = crossedDown;
            }
            else
            {
                crossedFull = crossedDown;
                crossedHalf = crossedUp;
            }

            // Is it a zero crossing?
            if (crossedFull)
            {
                // Yes!
                _prevSample = value;

                // Store sample count, reset it and return it
                int retv = _samplesSinceLastCrossing;
                _samplesSinceLastCrossing = 0;

                if (Method == CycleLengthMethod.PositiveDutyLength)
                {
                    retv = _dutySamples * 2;
                }
                else if (Method == CycleLengthMethod.NegativeDutyLength)
                {
                    retv = (retv - _dutySamples) * 2;
                }

                // Work out duty cycle
                _dutyCycle = (float)_dutySamples / retv;

                return retv;
            }

            if (crossedHalf)
            {
                _dutySamples = _samplesSinceLastCrossing;
            }

            // Just store the sample value
            _prevSample = value;
            return 0;
        }

        // return length of last cycle
        public int CurrentCycleLength()
        {
            return _samplesSinceLastCrossing;
        }

        public double CurrentDutyCycle()
        {
            return _dutyCycle;
        }
    }
}
