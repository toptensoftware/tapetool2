using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [Filter("mono", "Mixes a multi-channel audio stream to mono")]
    class FilterAudioMono : FilterAudio
    {
        public FilterAudioMono()
        {
        }

        FilterAudio _source;

        [Source]
        public FilterAudio Source
        {
            get { return _source; }
            set { _source = value; }
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
            double total = 0;

            for (int i=0; i<_source.ChannelCount; i++)
            {
                total += _source.GetSample(i);
            }

            return (float)(total / _source.ChannelCount);
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
