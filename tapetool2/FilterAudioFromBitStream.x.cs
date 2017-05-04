using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    class FilterAudioFromBitStream : FilterAudio
    {
        public FilterAudioFromBitStream(FilterBitStream source)
        {
            _source = source;
            _highLevel = 0.75f;
            _lowLevel = -0.75f;
        }

        FilterBitStream _source;
        float _highLevel;
        float _lowLevel;

        public override bool SetArgument(string name, string value)
        {
            switch (name)
            {
                case "high":
                    {
                        float rate;
                        if (!float.TryParse(value, out rate))
                        {
                            throw new InvalidOperationException("Invalid argument to gain /high.");
                        }

                        _highLevel = rate;
                        return true;
                    }

                case "low":
                    {
                        float rate;
                        if (!float.TryParse(value, out rate))
                        {
                            throw new InvalidOperationException("Invalid argument to gain /low.");
                        }

                        _lowLevel = rate;
                        return true;
                    }
            }

            return base.SetArgument(name, value);
        }

        public override int ChannelCount
        {
            get { return 1; }
        }

        public override int SampleRate
        {
            get { return _source.SampleRate; }
        }

        public override float GetSample(int channel)
        {
            return _source.GetSample() ? _highLevel : _lowLevel;
        }

        public override void Next()
        {
            _source.Next();
        }

        public override int BitsPerSample
        {
            get { return 16; }
        }

        public override bool IsEof
        {
            get
            {
                return _source.IsEof;
            }
        }

        public override Filter Source
        {
            get
            {
                return _source;
            }
        }
    }
}
