using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [Filter("adjustBias", "Adjusts the audio bias level of an audio stream")]
    class FilterAudioBiasAdjust : FilterAudio
    {
        public FilterAudioBiasAdjust()
        {
        }

        FilterAudio _source;
        [Source]
        public FilterAudio Source
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

        public override int ChannelCount
        {
            get { return _source.ChannelCount; }
        }

        public override int SampleRate
        {
            get { return _source.SampleRate; }
        }

        public override float GetSample(int channel)
        {
            return _source.GetSample(channel) + _amount;
        }

        public override bool Next()
        {
            return _source.Next();
        }

        public override int BitsPerSample
        {
            get { return _source.BitsPerSample; }
        }

        public override IEnumerable<Filter> GetPrecedents()
        {
            yield return _source;
        }
    }
}
