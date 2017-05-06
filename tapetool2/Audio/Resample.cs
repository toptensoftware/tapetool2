using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Audio
{
    [Filter("resample", "Resamples an audio stream to a new sample rate")]
    class Resample : StreamBase, IAudioStream
    {
        public Resample()
        {
            _quality = Resampler.Quality.Medium;
            _targetSampleRate = 44100;
        }

        IAudioStream _input;
        int _targetSampleRate;
        Resampler.Quality _quality;

        [InputStream]
        public IAudioStream Input
        {
            get { return _input; }
            set { _input = value; }
        }


        class ChannelStream
        {
            public ChannelStream(Resampler r, double[] buffer)
            {
                _resampler = r;
                _sampleBuffer = buffer;
            }

            double[] _sampleBuffer;
            Resampler _resampler;

            public double CurrentSample;

            public void CalculateSample(double srcPosition)
            {
                CurrentSample = _resampler.Resample(_sampleBuffer, srcPosition);
            }

            public void Flush(int samples)
            {
                Array.Copy(_sampleBuffer, samples, _sampleBuffer, 0, _sampleBuffer.Length - samples);
            }

            public void Append(int position, double sample)
            {
                _sampleBuffer[position] = sample;
            }
        }

        List<ChannelStream> _channelStreams = new List<ChannelStream>();
        int _bufferSize;
        int _bufferFillLevel;
        int _bufferedSourceSamples;
        int _requiredSurroundingSamples;
        double _sourceSample;
        double _invConvRate;

        public override void Rewind()
        {
            // Base
            base.Rewind();

            // Reset
            _channelStreams.Clear();
            _bufferSize = 0;
            _bufferFillLevel = 0;
            _bufferedSourceSamples = 0;
            _requiredSurroundingSamples = 0;
            _sourceSample = 0;
            _invConvRate = 0;

            // Setup
            for (int i=0; i<ChannelCount; i++)
            {
                // Create a resampler
                var r = new Resampler(_input.SampleRate, _targetSampleRate, _quality);

                // How big should the buffer be?
                _requiredSurroundingSamples = r.RequiredSurroundingSamples;
                _bufferSize = 1024 + _requiredSurroundingSamples * 2;
                _invConvRate = r.InverseConversionRate;

                // Create channel stream
                _channelStreams.Add(new ChannelStream(r, new double[_bufferSize]));
            }

            // Source sample starts after the required sample
            _sourceSample = _requiredSurroundingSamples;
            _bufferFillLevel = _requiredSurroundingSamples;
            _bufferedSourceSamples = _requiredSurroundingSamples;
        }

        void FillBuffers()
        {
            // Buffer full?  Flush some samples...
            int bufferRange = (int)_sourceSample + _requiredSurroundingSamples;
            if (bufferRange >= _bufferSize)
            {
                int samplesToFlush = (int)_sourceSample - _requiredSurroundingSamples;
                for (int i=0; i<_channelStreams.Count; i++)
                {
                    _channelStreams[i].Flush(samplesToFlush);
                }
                _bufferFillLevel -= samplesToFlush;
                _bufferedSourceSamples -= samplesToFlush;
                _sourceSample -= samplesToFlush;
            }

            // Buffer too empty?  Read some more samples
            int additionalSamples = (int)_sourceSample + _requiredSurroundingSamples - _bufferFillLevel;
            if (additionalSamples > 0)
            {
                for (int i=0; i<additionalSamples; i++)
                {
                    if (_input.Next())
                    {
                        // Fill with source samples
                        for (int ch = 0; ch < ChannelCount; ch++)
                        {
                            _channelStreams[ch].Append(_bufferFillLevel, _input.GetSample(ch));
                        }
                        _bufferFillLevel++;
                        _bufferedSourceSamples++;
                    }
                    else
                    {
                        // EOF - fill with zeros
                        for (int ch = 0; ch < ChannelCount; ch++)
                        {
                            _channelStreams[ch].Append(_bufferFillLevel, 0);
                        }
                        _bufferFillLevel++;
                    }
                }
            }
        }

        [FilterOption("rate", "New sample rate")]
        public int Rate
        {
            get { return _targetSampleRate; }
            set { _targetSampleRate = value; }
        }

        [FilterOption("quality", "Resampler quality (0=low, 1=medium, 2=high)")]
        public int Quality
        {
            get { return (int)_quality; }
            set { _quality = (Resampler.Quality)value; }
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
                return _targetSampleRate;
            }
        }

        public float GetSample(int channel)
        {
            return (float)_channelStreams[channel].CurrentSample;
        }

        protected override bool OnNext()
        {
            FillBuffers();

            if (_sourceSample > _bufferedSourceSamples)
                return false;

            for (int i=0; i<_channelStreams.Count; i++)
            {
                _channelStreams[i].CalculateSample(_sourceSample);
            }

            _sourceSample += _invConvRate;
            return true;
        }

    }
}
