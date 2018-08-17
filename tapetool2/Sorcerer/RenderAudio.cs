using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Audio;

namespace tapetool2.Sorcerer
{
    [Filter("sorcerer.renderAudio", "Parses a Exidy Sorcerer block stream into an audio stream")]
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


        [InputStream]
        public IBlockStream Input
        {
            set
            {
                ((SetHeader)First).Input = value;
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
