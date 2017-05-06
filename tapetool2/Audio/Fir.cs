using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Audio
{
    class Fir : StreamBase, IAudioStream
    {
        public Fir()
        {
        }

        IAudioStream _input;
        [InputStream]
        public IAudioStream Input
        {
            get { return _input; }
            set { _input = value; }
        }

        protected int _freqLow = 0;
        protected int _freqHigh = 0;
        protected int _tapCount = 51;
        int _tailSamples;

        [FilterOption("taps", "Number of taps in FIR filter")]
        public int Taps
        {
            get { return _tapCount; }
            set { _tapCount = value; }
        }


        class ChannelStream
        {
            public ChannelStream(FirFilter fir)
            {
                _fir = fir;
            }

            public void Process(double sampleIn)
            {
                CurrentSample = _fir.ProcessSample(sampleIn);
            }

            public FirFilter _fir;
            public double CurrentSample;

        }

        List<ChannelStream> _channelStreams = new List<ChannelStream>();

        public override void Rewind()
        {
            base.Rewind();

            // Create channel stream
            for (int i = 0; i < ChannelCount; i++)
            {
                var fir = new FirFilter(51, _input.SampleRate, _freqLow, _freqHigh);
                _channelStreams.Add(new ChannelStream(fir));
            }

            // Number of tail samples to be processed before eof
            _tailSamples = _tapCount/2;

            // Preload the taps
            for (int i=0; i< _tapCount/2; i++)
            {
                ProcessSample();
            }
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        public int ChannelCount
        {
            get
            {
                return _input.ChannelCount;
            }
        }

        public int BitsPerSample
        {
            get
            {
                return _input.BitsPerSample;
            }
        }

        public int SampleRate
        {
            get
            {
                return _input.SampleRate;
            }
        }

        public float GetSample(int channel)
        {
            return (float)_channelStreams[channel].CurrentSample;
        }

        public override bool Next()
        {
            if (_tailSamples == 0)
                return false;

            ProcessSample();
            return true;
        }

        void ProcessSample()
        {
            if (_input.Next())
            {
                // Pump next sample from the source
                for (int i = 0; i < _channelStreams.Count; i++)
                {
                    _channelStreams[i].Process(_input.GetSample(i));
                }
            }
            else
            {
                // In tail - pump zeros
                for (int i = 0; i < _channelStreams.Count; i++)
                {
                    _channelStreams[i].Process(0);
                }
                _tailSamples--;
            }
        }

    }
}
