using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;

namespace tapetool2.MameBin
{
    [FileWriter("mamebinWriter", "MAME bin writer", "mame.bin")]
    class Writer : CompositeStream, IByteStream
    {
        public Writer()
        {
            Add(_formatter = new Formatter());
            Add(_binWriter = new BinaryWriter());
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
            return _binWriter.GetByte();
        }
    }
}
