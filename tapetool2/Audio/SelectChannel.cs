using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Audio
{
    [Filter("selectChannel", "Selects one channel from a multi-channel audio stream")]
    class SelectChanel : StreamBase, IAudioStream
    {
        public SelectChanel()
        {
            _channel = 0;
        }

        IAudioStream _source;
        int _channel;

        [Source]
        public IAudioStream Source
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

        public int ChannelCount
        {
            get { return 1; }
        }

        public int SampleRate
        {
            get { return _source.SampleRate; }
        }

        public float GetSample(int channel)
        {
            return _source.GetSample(_channel);
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
