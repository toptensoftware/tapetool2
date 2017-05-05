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

        IAudioStream _source;
        float _gain = 0.5f;

        [Source]
        public IAudioStream Source
        {
            get { return _source; }
            set { _source = value; }
        }

        [FilterOption("factor", "Amount to adjust audio gain by (default=0.5)")]
        public float factor
        {
            get { return _gain; }
            set { _gain = value; }
        }

        public int ChannelCount
        {
            get { return _source.ChannelCount; }
        }

        public int SampleRate
        {
            get { return _source.SampleRate; }
        }

        public float GetSample(int channel)
        {
            return _source.GetSample(channel) * _gain;
        }

        public override bool Next()
        {
            return _source.Next();
        }

        public int BitsPerSample
        {
            get { return _source.BitsPerSample; }
        }

        public override IEnumerable<IStream> GetPrecedents()
        {
            yield return _source;
        }
    }
}
