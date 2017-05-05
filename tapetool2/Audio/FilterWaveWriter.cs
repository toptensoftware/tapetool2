using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    [FileWriter("waveWriter", "Wave file writer", "wav", "Standard wav file")]
    class FilterWaveWriter : FilterAudio
    {
        public FilterWaveWriter()
        {
        }

        FilterAudio _source;

        [Source]
        public FilterAudio Source
        {
            get { return _source; }
            set { _source = value; }
        }

        [FilterOption("filename", "The file to write", IsFileName = true)]
        public string Filename
        {
            get;
            set;
        }

        FileStream _stream;
        BinaryWriter _binaryWriter;
        int _bitsPerSample;
        uint _dataLenFillinPosition;
        uint _totalSamples;

        [FilterOption("bps", "Bits per sample")]
        public int BitPerSample
        {
            get { return _bitsPerSample; }
            set { _bitsPerSample = value; }
        }

        void WriteHeader()
        {
            if (_bitsPerSample != 8 && _bitsPerSample != 16 && _bitsPerSample != 32)
            {
                throw new InvalidOperationException(string.Format("Unsupported sample width on wave writer: {0} bits", _bitsPerSample));
            }

            // RIFF header
            _binaryWriter.Write(WaveUtils.ChunkIdRiff);
            _binaryWriter.Write((uint)0);                   // Fill in later
            _binaryWriter.Write(WaveUtils.RiffTypeWave);

            int bytesPerSample = _bitsPerSample / 8;

            // Format Chunk
            _binaryWriter.Write((uint)(WaveUtils.ChunkIdFmt));
            _binaryWriter.Write((uint)(16));
            _binaryWriter.Write((ushort)(WaveUtils.Format.PCM));
            _binaryWriter.Write((ushort)(_source.ChannelCount));
            _binaryWriter.Write((uint)(_source.SampleRate));
            _binaryWriter.Write((uint)(_source.ChannelCount * bytesPerSample * _source.SampleRate));     // Avg bytes per second
            _binaryWriter.Write((ushort)(_source.ChannelCount * bytesPerSample));                          // Block align
            _binaryWriter.Write((ushort)(bytesPerSample * 8));

            // Data chunk
            _binaryWriter.Write(WaveUtils.ChunkIdData);
            _dataLenFillinPosition = (uint)_stream.Position;
            _binaryWriter.Write((uint)0);
        }

        void FillHeader()
        {
            // Fill in lengths
            _stream.Position = 4;
            _binaryWriter.Write((uint)(_stream.Length - 8));
            _stream.Position = _dataLenFillinPosition;
            _binaryWriter.Write((uint)(_stream.Length - _dataLenFillinPosition - 4));
        }

        public override void Rewind()
        {
            // Base
            base.Rewind();

            // Close
            Close();

            // Rewind
            _dataLenFillinPosition = 0;
            _totalSamples = 0;

            // Open output stream
            _stream = File.Create(Filename);
            _binaryWriter = new BinaryWriter(_stream, Encoding.UTF8, true);
            _bitsPerSample = _source.BitsPerSample;

            if (_bitsPerSample < 8)
                _bitsPerSample = 8;

            WriteHeader();
        }


        public override IEnumerable<Filter> GetPrecedents()
        {
            yield return _source;
        }

        public override int ChannelCount
        {
            get
            {
                return _source.ChannelCount;
            }
        }

        public override int BitsPerSample
        {
            get
            {
                return _bitsPerSample;
            }
        }

        public override int SampleRate
        {
            get
            {
                return _source.SampleRate;
            }
        }

        public override float GetSample(int channel)
        {
            return _source.GetSample(channel);
        }

        public override bool Next()
        {
            if (!_source.Next())
                return false;

            for (int i = 0; i < _source.ChannelCount; i++)
            {
                float sample = GetSample(i);
                if (sample < -1)
                    sample = -1;
                else if (sample > 1)
                    sample = 1;
                switch (_bitsPerSample)
                {
                    case 8:
                    {
                        byte b = (byte)((sample + 1) * 127);
                        _binaryWriter.Write(b);
                        break;
                    }

                    case 16:
                    {
                        short s = (short)(sample * 32767.0);
                        _binaryWriter.Write(s);
                        break;
                    }

                    case 32:
                    {
                        int s = (int)(sample * 2147483647.0);
                        _binaryWriter.Write(s);
                        break;
                    }

                    default:
                        throw new NotImplementedException();
                }
            }
            _totalSamples++;
            return true;
        }

        void Close()
        {
            if (_stream != null)
            {
                FillHeader();

                _binaryWriter.Dispose();
                _binaryWriter = null;
                _stream.Dispose();
                _stream = null;
            }

        }

        public override void Dispose()
        {
            Close();
            base.Dispose();
        }
    }
}
