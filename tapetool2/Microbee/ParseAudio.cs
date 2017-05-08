using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Audio;
using tapetool2.Tape;

namespace tapetool2.Microbee
{
    [Filter("microbee.parseAudio", "Parses a Microbee audio stream into block stream")]
    class ParseAudio : CompositeStream, IBlockStream, IBaudRateProvider
    {
        public ParseAudio()
        {
            Add(new AudioToBytes());
            Add(new BytesToBlocks());
        }


        [InputStream]
        public IAudioStream Input
        {
            set
            {
                ((AudioToBytes)First).Input = value;
            }
        }

        public int BaudRate
        {
            get
            {
                return ((IBaudRateProvider)Last).BaudRate;
            }
        }

        public TapeHeader Header
        {
            get
            {
                return ((BytesToBlocks)Last).Header;
            }
        }

        public Block GetBlock()
        {
            return ((BytesToBlocks)Last).GetBlock();
        }
    }
}
