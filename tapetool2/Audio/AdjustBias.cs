using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Audio
{
    [Filter("adjustBias", "Adjusts the audio bias level of an audio stream")]
    class AdjustBias : StreamBase, IAudioStream
    {
        public AdjustBias()
        {
        }

        IAudioStream _input;
        [InputStream]
        public IAudioStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        float _amount;
        [FilterOption("amount", "Amount to add to audio samples")]
        public float Amount
        {
            get { return _amount; }
            set { _amount = value; }
        }

        public int ChannelCount
        {
            get { return _input.ChannelCount; }
        }

        public int SampleRate
        {
            get { return _input.SampleRate; }
        }

        public float GetSample(int channel)
        {
            return _input.GetSample(channel) + _amount;
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
