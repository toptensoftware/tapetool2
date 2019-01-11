using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;

namespace tapetool2.MameBin
{
    [FileReader("mamebin.reader", "MAME bin reader", "mame.bin")]
    class Reader : IMameStream
    {
        public Reader()
        {
            _binReader = new BinaryReader();
            _parser = new Parser();
            _parser.Input = _binReader;
        }

        [FilterOption("filename", "The file to read", IsFileName = true)]
        public string Filename
        {
            get => _binReader.Filename;
            set => _binReader.Filename = value;
        }

        public MameHeader Header => ((IMameStream)_parser).Header;

        BinaryReader _binReader;
        Parser _parser;

        public byte GetByte()
        {
            return ((IMameStream)_parser).GetByte();
        }

        public void Rewind()
        {
            ((IMameStream)_parser).Rewind();
        }

        public bool Next()
        {
            return ((IMameStream)_parser).Next();
        }

        public void SetInput(IStream stream, List<string> usingNamespaces)
        {
            ((IMameStream)_parser).SetInput(stream, usingNamespaces);
        }

        public IEnumerable<IStream> EnumStreams()
        {
            return ((IMameStream)_parser).EnumStreams();
        }

        public IStream UpstreamOfType(Type filterType)
        {
            return ((IMameStream)_parser).UpstreamOfType(filterType);
        }

        public bool SetArgument(string name, string value)
        {
            return ((IMameStream)_parser).SetArgument(name, value);
        }

        public IEnumerable<FilterOptionAttribute> GetOptions()
        {
            return ((IMameStream)_parser).GetOptions();
        }

        public void WriteSummary(System.IO.TextWriter w)
        {
            ((IMameStream)_parser).WriteSummary(w);
        }

        public void Dispose()
        {
            ((IMameStream)_parser).Dispose();
        }
    }
}
