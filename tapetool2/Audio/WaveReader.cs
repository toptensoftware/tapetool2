using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Audio
{
    [FileReader("waveReader", "Wave file reader", "wav")]
    class WaveReader : StreamBase, IAudioStream
    {
        public WaveReader()
        {
        }

        [FilterOption("filename", "The file to read", IsFileName = true)]
        public string Filename
        {
            get;
            set;
        }

        
        void ReadHeader()
        {
            // Read the RIFF header
            var chunkId = _binaryReader.ReadUInt32();
            var chunkLen = _binaryReader.ReadUInt32();
            var riffType = _binaryReader.ReadUInt32();
            if (chunkId != WaveUtils.ChunkIdRiff || riffType != WaveUtils.RiffTypeWave)
                throw new InvalidDataException(string.Format("{0} is not a valid wave file", Filename));
                                                                                                                                                        
            // Read chunks
            while (_stream.Position + 4 < _stream.Length)
            {
                chunkId = _binaryReader.ReadUInt32();
                chunkLen = _binaryReader.ReadUInt32();

                // Data chunk
                if (chunkId == WaveUtils.ChunkIdData)
                {
                    _dataLength = chunkLen;
                    _dataOffset = (uint)_stream.Position;
                    _stream.Seek(chunkLen, SeekOrigin.Current);
                    continue;
                }

                // Format chunk?
                if (chunkId == WaveUtils.ChunkIdFmt)
                {
                    var nextChunk = _stream.Position + chunkLen;
                    _formatTag = (WaveUtils.Format)_binaryReader.ReadInt16();
                    _channelCount = _binaryReader.ReadUInt16();
                    _sampleRate = _binaryReader.ReadInt32();
                    _binaryReader.ReadInt32();     // Avg bytes per second - don't care
                    _binaryReader.ReadUInt16();    // Block align - don't care
                    _bitsPerSample = _binaryReader.ReadUInt16();
                    _stream.Position = nextChunk;
                    continue;
                }

                // Skip other chunks
                _stream.Seek(chunkLen, SeekOrigin.Current);
                continue;
            }
        }

        void ReadSample()
        {
            for (int i=0; i<_channelCount; i++)
            {
                switch (_bitsPerSample)
                {
                    case 8:
                        _samples[i] = (_binaryReader.ReadByte() - 0x80) / 128f;
                        break;

                    case 16:
                        _samples[i] = _binaryReader.ReadInt16() / 32768f;
                        break;

                    case 32:
                        _samples[i] = _binaryReader.ReadInt32() / 2147483648f;
                        break;

                    default:
                        throw new NotImplementedException();
                }
            }
            _currentSample++;
        }

        FileStream _stream;
        BinaryReader _binaryReader;
        uint _dataLength;
        uint _dataOffset;
        WaveUtils.Format _formatTag;
        int _channelCount;
        int _sampleRate;
        int _bitsPerSample;
        float[] _samples;
        uint _totalSamples;
        uint _currentSample;

        public override void Rewind()
        {
            // Base
            base.Rewind();

            // Close
            Close();

            // Rewind
            _dataLength = 0;
            _dataOffset = 0;
            _formatTag = WaveUtils.Format.PCM;
            _channelCount = 0;
            _sampleRate = 0;
            _bitsPerSample = 0;
            _samples = null;
            _totalSamples = 0;
            _currentSample = 0;

            // Open stream
            _stream = File.OpenRead(Filename);
            _binaryReader = new BinaryReader(_stream, Encoding.UTF8, true);

            // Read header
            ReadHeader();

            if (_formatTag != WaveUtils.Format.PCM)
                throw new InvalidDataException("Unsupported wave format");
            if (_bitsPerSample != 8 && _bitsPerSample != 16 && _bitsPerSample != 32)
                throw new InvalidDataException("Unsupported wave sample width");
            if (_channelCount < 1 || _channelCount > 16)
                throw new InvalidDataException("Unsupported wave channel count");
            if (_dataOffset == 0)
                throw new InvalidDataException("Didn't find a data chunk in wave file");

            // Allocate buffer for samples
            _samples = new float[_channelCount];

            // Seek to start of data
            _stream.Position = _dataOffset;

            // Calculate total samples
            _totalSamples = (uint)((_dataLength / (uint)(_bitsPerSample / 8)) / _channelCount);
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield break;
        }

        public int ChannelCount
        {
            get
            {
                return _channelCount;
            }
        }

        public int BitsPerSample
        {
            get
            {
                return _bitsPerSample;
            }
        }

        public int SampleRate
        {
            get
            {
                return _sampleRate;
            }
        }

        public float GetSample(int channel)
        {
            return _samples[channel];
        }

        protected override bool OnNext()
        {
            if (_currentSample >= _totalSamples)
                return false;
            ReadSample();
            return true;
        }

        void Close()
        {
            if (_stream != null)
            {
                _binaryReader.Dispose();
                _binaryReader = null;
                _stream.Dispose();
                _stream = null;
            }
        }

        public override void Dispose()
        {
            Close();
            base.Dispose();
        }

        public override void WriteSummary(TextWriter w)
        {
            base.WriteSummary(w);
            w.WriteLine("    total samples: {0}", _totalSamples);
            w.WriteLine("    sample rate: {0}Hz", _sampleRate);
            w.WriteLine("    channels: {0}", _channelCount);
            w.WriteLine("    bits per sample: {0}", _bitsPerSample);
        }
    }
}
