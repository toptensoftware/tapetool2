using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [Filter("singleBitAudioToAudio", "Convert a single bit audio stream to an audio stream")]
    class FilterSingleBitAudioToAudio : FilterAudio
    {
        public FilterSingleBitAudioToAudio()
        {
            _highLevel = 0.75f;
            _lowLevel = -0.75f;
        }

        FilterSingleBitAudioStream _source;

        [Source]
        public FilterSingleBitAudioStream Source
        {
            get { return _source; }
            set { _source = value; }
        }

        float _highLevel;
        float _lowLevel;

        [FilterOption("high", "Audio level for 1 bits (default=0.75)")]
        public float HighLevel
        {
            get { return _highLevel; }
            set { _highLevel = value; }
        }

        [FilterOption("low", "Audio level for 0 bits (default=-0.75")]
        public float LowLevel
        {
            get { return _lowLevel; }
            set { _lowLevel = value; }
        }

        public override int ChannelCount
        {
            get { return 1; }
        }

        public override int SampleRate
        {
            get { return _source.SampleRate; }
        }

        public override float GetSample(int channel)
        {
            return _source.GetSample() ? _highLevel : _lowLevel;
        }

        public override bool Next()
        {
            return _source.Next();
        }

        public override int BitsPerSample
        {
            get { return 16; }
        }

        public override IEnumerable<Filter> GetPrecedents()
        {
            yield return _source;
        }
    }
}
