using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Audio
{
    [Filter("gain", "Adjusts the volume level of an audio stream")]
    class Gain : StreamBase, IAudioStream
    {
        public Gain()
        {
        }

        IAudioStream _input;
        float _gain = 0.5f;

        [InputStream]
        public IAudioStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        [FilterOption("factor", "Amount to adjust audio gain by (default=0.5)")]
        public float factor
        {
            get { return _gain; }
            set { _gain = value; }
        }

        public int ChannelCount
        {
            get { return _input.ChannelCount; }
        }

        public int SampleRate
        {
            get { return _input.SampleRate; }
        }

        public float GetSample(int channel)
        {
            return _input.GetSample(channel) * _gain;
        }

        public override bool Next()
        {
            return _input.Next();
        }

        public int BitsPerSample
        {
            get { return _input.BitsPerSample; }
        }

        public override IEnumerable<IStream> GetPrecedents()
        {
            yield return _input;
        }
    }
}
