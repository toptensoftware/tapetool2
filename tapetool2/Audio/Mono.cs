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

        IAudioStream _input;

        [InputStream]
        public IAudioStream Input
        {
            get { return _input; }
            set { _input = value; }
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
            double total = 0;

            for (int i=0; i<_input.ChannelCount; i++)
            {
                total += _input.GetSample(i);
            }

            return (float)(total / _input.ChannelCount);
        }

        public override bool Next()
        {
            return _input.Next();
        }

        public int BitsPerSample
        {
            get { return _input.BitsPerSample; }
        }

        public override IEnumerable<IStream> GetInputs()
        {
            yield return _input;
        }
    }
}
