using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Audio
{
    [Filter("changeRate", "Changes the sample rate of an audio stream without resampling it")]
    class ChangeRate : StreamBase, IAudioStream
    {
        public ChangeRate()
        {
        }

        IAudioStream _input;

        [InputStream]
        public IAudioStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        int _to = 44100;
        [FilterOption("to", "New sample rate (default:44100)")]
        public int To
        {
            get { return _to; }
            set { _to = value; _by = 0;  }
        }

        double _by = 0;
        [FilterOption("by", "Amount to sample rate byte (eg: 0.9)")]
        public double By
        {
            get { return _by; }
            set { _by = value; _to = 0; }
        }

        public int ChannelCount
        {
            get { return _input.ChannelCount; }
        }

        public int SampleRate
        {
            get
            {
                if (_to != 0)
                    return _to;
                if (_by != 0)
                    return (int)(_input.SampleRate * _by);
                return _input.SampleRate;
            }
        }

        public float GetSample(int channel)
        {
            return _input.GetSample(channel);
        }

        public override bool Next()
        {
            return _input.Next();
        }

        public int BitsPerSample
        {
            get { return _input.BitsPerSample; }
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }
    }
}
