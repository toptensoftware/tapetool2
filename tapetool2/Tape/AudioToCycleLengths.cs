using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Audio;
using tapetool2.Tape;

namespace tapetool2.Tape
{
    [Filter("audioToCycleLengths", "Generates audio cycle lengths from an audio stream")]
    class AudioToCycleLengths : StreamBase, ICycleLengthStream
    {
        public AudioToCycleLengths()
        {
        }

        CycleLengthDetector _cld = new CycleLengthDetector() { Method = CycleLengthMethod.ZeroCrossingUp };

        IAudioStream _input;

        [InputStream]
        public IAudioStream Input
        {
            get { return _input; }
            set
            {
                _input = value;
            }
        }
        
        [FilterOption("cycleMethod", "sets the method used to measure cycle lengths (zc, zc+, zc-, duty+ or duty-). Default = zc+")]
        public string cycleMethod
        {
            set
            {
                _cld.Method = CycleLengthDetector.ParseMethod(value);
            }
        }

        public override void Rewind()
        {
            base.Rewind();

            _cld.Reset();

            _eof = false;
        }

        bool _eof;


        // Find the next zero crossing and return the number of samples passed
        int FindEdge()
        {
            if (_eof)
                return -1;
            while (_input.Next())
            {
                int samples = _cld.Update(_input.GetSample(0));
                if (samples != 0)
                    return samples;
            }

            _eof = true;
            return _cld.CurrentCycleLength();
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        int _cycleCycleLength;

        protected override bool OnNext()
        {
            _cycleCycleLength = FindEdge();
            return _cycleCycleLength >= 0;
        }

        public override void WriteSummary(TextWriter w)
        {
            base.WriteSummary(w);
            w.WriteLine("    cycle method: {0}", _cld.Method.ToString());
        }


        public int CurrentCycleLength
        {
            get => _cycleCycleLength;
        }

        public int SampleRate
        {
            get => _input.SampleRate;
        }
    }
}
