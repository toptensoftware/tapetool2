using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Audio
{
    [Filter("channelMultiCast", "Multicasts a single audio channel to multiple identical channels")]
    class ChannelMultiCast : StreamBase, IAudioStream
    {
        public ChannelMultiCast()
        {
            _channels = 2;
        }

        IAudioStream _source;
        int _channels;

        [Source]
        public IAudioStream Source
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

        public int ChannelCount
        {
            get { return _channels; }
        }

        public int SampleRate
        {
            get { return _source.SampleRate; }
        }

        public float GetSample(int channel)
        {
            return _source.GetSample(0);
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
