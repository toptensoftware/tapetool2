using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [Filter("selectChannel", "Selects one channel from a multi-channel audio stream")]
    class FilterAudioSelectChannel : FilterAudio
    {
        public FilterAudioSelectChannel()
        {
            _channel = 0;
        }

        FilterAudio _source;
        int _channel;

        [Source]
        public FilterAudio Source
        {
            get { return _source; }
            set { _source = value; }
        }



        [FilterOption("channel", "The channel to select from the source audio stream (default=0)")]
        public int Channel
        {
            get { return _channel; }
            set { _channel = value; }
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
            return _source.GetSample(_channel);
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
