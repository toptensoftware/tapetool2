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

        IAudioStream _input;
        int _channels;

        [InputStream]
        public IAudioStream Input
        {
            get { return _input; }
            set { _input = value; }
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
            get { return _input.SampleRate; }
        }

        public float GetSample(int channel)
        {
            return _input.GetSample(0);
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
