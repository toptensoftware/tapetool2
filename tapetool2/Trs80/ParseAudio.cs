using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Audio;
using tapetool2.Tape;

namespace tapetool2.Trs80
{
    [Filter("trs80.parseAudio", "Parses a TRS-80 audio stream into block stream")]
    class ParseAudio : CompositeStream, IBlockStream
    {
        public ParseAudio()
        {
            Add(new AudioToCycleLengths());
            Add(new CycleLengthsToCycleKinds() { HighFreq = 1000, LowFreq = 500 });
            Add(new CycleKindsToBits());
            Add(new BitsToBytes());
            Add(new BytesToBlocks());
        }


        [InputStream]
        public IAudioStream Input
        {
            set
            {
                ((AudioToCycleLengths)First).Input = value;
            }
        }

        public Header Header => ((BytesToBlocks)Last).Header;
        public Block CurrentBlock => ((BytesToBlocks)Last).CurrentBlock;
    }
}
