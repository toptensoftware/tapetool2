using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Audio
{
    [Filter("mono", "Mixes a multi-channel audio stream to mono")]
    class Mono : StreamBase, IAudioStream
    {
        public Mono()
        {
        }

        IAudioStream _source;

        [Source]
        public IAudioStream Source
        {
            get { return _source; }
            set { _source = value; }
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
