using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [Filter("channelMultiCast", "Multicasts a single audio channel to multiple identical channels")]
    class FilterAudioChannelMultiCast : FilterAudio
    {
        public FilterAudioChannelMultiCast()
        {
            _channels = 2;
        }

        FilterAudio _source;
        int _channels;

        [Source]
        public FilterAudio Source
        {
            get { return _source; }
            set { _source = value; }
        }

        [FilterOption("channels", "Number of output audio channels (default=2)")]
        public int Channels
        {
            get { return _channels; }
            set { _channels = value; }
        }

        public override int ChannelCount
        {
            get { return _channels; }
        }

        public override int SampleRate
        {
            get { return _source.SampleRate; }
        }

        public override float GetSample(int channel)
        {
            return _source.GetSample(0);
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
