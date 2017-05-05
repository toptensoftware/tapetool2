using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Microbee
{
    [FileReader("microbeeTapFileReader", "Microbee tape file reader", "tap", "Microbee tap file")]
    class TapFileReader : StreamBase, IByteStream
    {
        public TapFileReader()
        {
        }

        [FilterOption("filename", "The file to read", IsFileName = true)]
        public string Filename
        {
            get;
            set;
        }

        FileStream _stream;
        byte _currentByte;

        public override void Rewind()
        {
            // Base
            base.Rewind();

            // Close
            Close();

            // Open source stream
            _stream = File.OpenRead(Filename);
            using (var br = new BinaryReader(_stream, Encoding.UTF8, true))
            {
                // Read and check the header
                var str = new string(br.ReadChars(13), 0, 13);
                if (str != "TAP_DGOS_MBEE")
                    throw new InvalidDataException("Not a TAP file");
            }
        }

        public override IEnumerable<IStream> GetPrecedents()
        {
            yield break;
        }

        public byte GetByte()
        {
            return _currentByte;
        }

        public override bool Next()
        {
            if (_stream.Position >= _stream.Length)
                return false;
            _currentByte = (byte)_stream.ReadByte();
            return true;
        }

        void Close()
        {
            if (_stream != null)
            {
                _stream.Dispose();
                _stream = null;
            }
        }

        public override void Dispose()
        {
            Close();
            base.Dispose();
        }

        /*
        public override Filter ConvertTo(Type filterType)
        {
            if (filterType == typeof(ITapStream))
            {
                var s1 = new FilterTapStreamDecoder();
                s1.Source = this;
                return s1;
            }

            if (filterType == typeof(IBitStream))
            {
                // Decode and re-encode so that we can pick up the speed
                // setting from the header and use it in later cycle rendering
                var s1 = new FilterTapStreamDecoder();
                s1.Source = this;
                var s2 = new ITapStreamEncoder();
                s2.Source = s1;

                // Encode bytes to bits
                var s3 = new FilterByteEncoder();
                s3.Source = s2;

                return (IBitStream)s3;
            }

            if (filterType == typeof(ICycleKindStream))
            {
                // Encode bits to cycle kinds
                var s4 = new FilterCycleKindGenerator();
                s4.Source = ConvertTo<IBitStream>();
                return (ICycleKindStream)s4;
            }

            if (filterType == typeof(FilterAudio))
            {
                // Render cycle kinds as audio samples
                var s5 = new FilterAudioCycleGenerator();
                s5.Source = ConvertTo<ICycleKindStream>();
                return (FilterAudio)s5;
            }

            return null;
        }
        */
    }
}
