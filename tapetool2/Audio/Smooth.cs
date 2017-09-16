using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Audio
{
    [Filter("smooth", "Smooths audio using a moving average")]
    class Smooth : StreamBase, IAudioStream
    {
        public Smooth()
        {
        }

        IAudioStream _input;
        MovingAverage _ma = new MovingAverage(8);

        [InputStream]
        public IAudioStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        [FilterOption("period", "Smoothing period in samples (default=8)")]
        public int Period
        {
            get { return _ma.Period; }
            set { _ma.Period = value; }
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
            return (float)_ma.Value;
        }

        protected override bool OnNext()
        {
            if (!_input.Next())
                return false;
            _ma.Add(_input.GetSample(0));
            return true;
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
