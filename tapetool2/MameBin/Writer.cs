using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;

namespace tapetool2.MameBin
{
    [FileWriter("mamebin.writer", "MAME bin writer", "mame.bin")]
    class Writer : IByteStream
    {
        public Writer()
        {
            _formatter = new Formatter();
            _binWriter = new BinaryWriter();
            _binWriter.Input = _formatter;
        }

        [FilterOption("filename", "The file to read", IsFileName = true)]
        public string Filename
        {
            get => _binWriter.Filename;
            set => _binWriter.Filename = value;
        }

        BinaryWriter _binWriter;
        Formatter _formatter;

        public byte GetByte()
        {
            return ((IByteStream)_binWriter).GetByte();
        }

        public void Rewind()
        {
            ((IByteStream)_binWriter).Rewind();
        }

        public bool Next()
        {
            return ((IByteStream)_binWriter).Next();
        }

        public void SetInput(IStream stream, List<string> usingNamespaces)
        {
            ((IByteStream)_binWriter).SetInput(stream, usingNamespaces);
        }

        public IEnumerable<IStream> EnumStreams()
        {
            return ((IByteStream)_binWriter).EnumStreams();
        }

        public IStream UpstreamOfType(Type filterType)
        {
            return ((IByteStream)_binWriter).UpstreamOfType(filterType);
        }

        public bool SetArgument(string name, string value)
        {
            return ((IByteStream)_binWriter).SetArgument(name, value);
        }

        public IEnumerable<FilterOptionAttribute> GetOptions()
        {
            return ((IByteStream)_binWriter).GetOptions();
        }

        public void WriteSummary(System.IO.TextWriter w)
        {
            ((IByteStream)_binWriter).WriteSummary(w);
        }

        public void Dispose()
        {
            ((IByteStream)_binWriter).Dispose();
        }
    }
}
