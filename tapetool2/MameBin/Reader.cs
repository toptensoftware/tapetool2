using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;

namespace tapetool2.MameBin
{
    [FileReader("mamebinReader", "MAME bin reader", "mame.bin")]
    class Reader : CompositeStream, IMameStream
    {
        public Reader()
        {
            Add(_binReader = new BinaryReader());
            Add(_parser = new Parser());
        }

        [FilterOption("filename", "The file to read", IsFileName = true)]
        public string Filename
        {
            get => _binReader.Filename;
            set => _binReader.Filename = value;
        }

        BinaryReader _binReader;
        Parser _parser;

        public MameHeader Header => _parser.Header;
        public byte GetByte() => _parser.GetByte();
    }
}
