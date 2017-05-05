using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Microbee
{
    class StreamConversions
    {
        [StreamConverter]
        public static IBlockStream ConvertTapToBlocks(TapFileReader reader)
        {
            return new BytesToBlocks() { Input = reader };
        }

        [StreamConverter]
        public static IAudioStream ConvertBlocksToAudio(IBlockStream blocks)
        {
            return new RenderAudio() { Input = blocks };
        }

        [StreamConverter]
        public static IAudioStream ConvertTapFileToAudio(TapFileReader reader)
        {
            return new RenderAudio() { Input = new BytesToBlocks() { Input = reader } };
        }

        [StreamConverter]
        public static IBlockStream ConvertAudioToBlocks(IAudioStream audio)
        {
            return new ParseAudio() { Input = audio };
        }

        [StreamConverter(typeof(TapFileWriter))]
        public static IByteStream ConvertAudioToTapFile(IAudioStream audio)
        {
            return new BlocksToBytes() { Input = new ParseAudio() { Input = audio } };
        }

    }
}
