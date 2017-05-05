using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Audio
{
    [Filter("adjustBias", "Adjusts the audio bias level of an audio stream")]
    class AdjustBias : StreamBase, IAudioStream
    {
        public AdjustBias()
        {
        }

        IAudioStream _source;
        [Source]
        public IAudioStream Source
        {
            get { return _source; }
            set { _source = value; }
        }

        float _amount;
        [FilterOption("amount", "Amount to add to audio samples")]
        public float Amount
        {
            get { return _amount; }
            set { _amount = value; }
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
            return _source.GetSample(channel) + _amount;
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
