using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Microbee
{
    [Filter("microbee.renderAudio", "Parses a Microbee block stream into audio stream")]
    class RenderAudio : CompositeStream, IAudioStream
    {
        public RenderAudio()
        {
            Add(new SetHeader());
            Add(new BlocksToBytes());
            Add(new BytesToBits());
            Add(new BitsToCycleKinds());
            Add(_last = new CycleKindsToAudio());
        }

        IAudioStream _last;


        [Source]
        public IBlockStream Source
        {
            set
            {
                ((SetHeader)First).Source = value;
            }
        }

        public int ChannelCount
        {
            get
            {
                return _last.ChannelCount;
            }
        }

        public int SampleRate
        {
            get
            {
                return _last.SampleRate;
            }
        }

        public int BitsPerSample
        {
            get
            {
                return _last.BitsPerSample;
            }
        }

        public float GetSample(int channel)
        {
            return _last.GetSample(channel);
        }
    }
}
