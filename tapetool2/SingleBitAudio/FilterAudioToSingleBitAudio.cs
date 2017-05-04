using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [Filter("audioToSingleBitAudio", "Converts an audio stream to a single bit audio stream")]
    class FilterAudioToSingleBitAudio : FilterSingleBitAudioStream
    {
        public FilterAudioToSingleBitAudio()
        {
            _threshold = 0.0f;
        }

        FilterAudio _source;
        float _threshold = 0.0f;

        [Source]
        public FilterAudio Source
        {
            get { return _source; }
            set { _source = value; }
        }

        [FilterOption("threshold", "audio level threshold for bit value 1")]
        public float Threshold
        {
            get { return _threshold; }
            set { _threshold = value; }
        }

        public override int SampleRate
        {
            get { return _source.SampleRate; }
        }

        public override bool GetSample()
        {
            return _source.GetSample(0) >= _threshold;
        }

        public override bool Next()
        {
            return _source.Next();
        }

        public override IEnumerable<Filter> GetPrecedents()
        {
            yield return _source;
        }
    }

}
