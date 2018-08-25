using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Audio;
using tapetool2.Tape;

namespace tapetool2.Trs80
{
    [Filter("trs80.cycleKindsToAudio", "Generates TRS-80 audio from a cycle kind stream")]
    class CycleKindsToAudio : StreamBase, IAudioStream
    {
        public CycleKindsToAudio()
        {
        }

        ICycleKindStream _input;
    
        [InputStream]
        public ICycleKindStream Input
        {
            get { return _input; }
            set
            {
                _input = value;
            }
        }

        int _sampleRate = 22050;
        float _volume = 0.75f;

        [FilterOption("sampleRate", "sample rate at which to render")]
        public int SampleRateOption
        {
            set
            {
                _sampleRate = value;
            }
        }

        [FilterOption("volume", "volume which to render (default=0.75)")]
        public float Volume
        {
            set
            {
                _volume = value;
            }
        }

        [FilterOption("highFreq", "frequency of high-frequency cycles (default=1000Hz)")]
        public int HighFreq
        {
            get;
            set;
        } = 1000;

        [FilterOption("lowFreq", "frequency of low-frequency cycles (default=500Hz)")]
        public int LowFreq
        {
            get;
            set;
        } = 500;

        [FilterOption("pulseFreq", "frequency of each pulse (default=10,00Hz)")]
        public int PulseFreq
        {
            get;
            set;
        } = 10000;



        public int SampleRate
        {
            get
            {
                return _sampleRate;
            }
        }

        public int ChannelCount
        {
            get
            {
                return 1;
            }
        }


        public int BitsPerSample
        {
            get
            {
                return 8;
            }
        }


        int _currentSampleNumberInThisCycle;
        int _currentCycleSampleCount;
        int _halfPulseSampleCount;
        int _highCycleSampleCount;
        int _lowCycleSampleCount;

        public override void Rewind()
        {
            base.Rewind();
            _currentCycleSampleCount = 0;
            _currentSampleNumberInThisCycle = 0;
            _halfPulseSampleCount = Math.Max(1, (SampleRate / PulseFreq) / 2);
            _highCycleSampleCount = SampleRate / HighFreq;
            _lowCycleSampleCount = SampleRate / LowFreq;
            if (_halfPulseSampleCount * 2 >= Math.Min(_highCycleSampleCount, _lowCycleSampleCount))
                throw new InvalidOperationException("Pulse duration is longer than cycle");
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        public float GetSample(int channel)
        {
            if (_currentSampleNumberInThisCycle < _halfPulseSampleCount)
                return _volume;
            if (_currentSampleNumberInThisCycle < _halfPulseSampleCount * 2)
                return -_volume;
            return 0;
        }

        protected override bool OnNext()
        {
            if (_currentSampleNumberInThisCycle < _currentCycleSampleCount)
            {
                _currentSampleNumberInThisCycle++;
                return true;
            }

            if (!_input.Next())
                return false;

            switch (_input.GetCycleKind())
            {
                case CycleKind.High:
                case CycleKind.TooHigh:
                    _currentCycleSampleCount = _highCycleSampleCount;
                    break;

                default:
                    _currentCycleSampleCount = _lowCycleSampleCount;
                    break;
            }

            _currentSampleNumberInThisCycle = 0;
            return true;
        }
    }
}
