using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;

namespace tapetool2.Trs80
{
    [FileReader("trs80.textBlockStreamReader", "Text block-stream file reader", ".blocks.txt")]
    class TextBlockStreamReader : CompositeStream, IBlockStream
    {
        public TextBlockStreamReader()
        {
            Add(_textReader = new TextByteStreamReader());
            Add(_bytesToBlocks = new BytesToBlocks() { SkipLeadin = false });
        }

        TextByteStreamReader _textReader;
        BytesToBlocks _bytesToBlocks;

        [FilterOption("filename", "The file to read", IsFileName = true)]
        public string Filename
        {
            get { return _textReader.Filename; }
            set { _textReader.Filename = value; }
        }

        public Header Header => ((IBlockStream)_bytesToBlocks).Header;

        public Block CurrentBlock => ((IBlockStream)_bytesToBlocks).CurrentBlock;
    }
}     