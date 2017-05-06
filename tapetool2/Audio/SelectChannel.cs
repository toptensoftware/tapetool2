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

        IAudioStream _input;
        int _channel;

        [InputStream]
        public IAudioStream Input
        {
            get { return _input; }
            set { _input = value; }
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
            get { return _input.SampleRate; }
        }

        public float GetSample(int channel)
        {
            return _input.GetSample(_channel);
        }

        protected override bool OnNext()
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
