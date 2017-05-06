using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Audio;
using tapetool2.Binary;
using tapetool2.Tape;

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

        [StreamConverter(TargetObjectType = typeof(TapFileWriter))]
        public static IByteStream ConvertAudioToTapFile(IAudioStream audio)
        {
            return new BlocksToBytes() { Input = new ParseAudio() { Input = audio } };
        }

        [StreamConverter(Namespace = "microbee")]
        public static ICycleKindStream ConvertAudioToCycleKinds(IAudioStream audio)
        {
            return new AudioToCycleKinds() { Input = audio };
        }

        [StreamConverter(Namespace = "microbee")]
        public static IBitStream ConvertAudioToBits(IAudioStream audio)
        {
            return new BytesToBits()
            {
                Input = new BlocksToBytes()
                {
                    Input = new ParseAudio()
                    {
                        Input = audio
                    }
                }
            };
        }

        [StreamConverter(Namespace = "microbee")]
        public static IAudioStream ConvertBitsToAudio(IBitStream from)
        {
            return new RenderAudio()
            {
                Input = new BytesToBlocks()
                {
                    Input = new BitsToBytes()
                    {
                        Input = from
                    }
                }
            };
        }

        [StreamConverter(Namespace="microbee")]
        public static IAudioStream ConvertCycleKindsToAudio(ICycleKindStream cycles)
        {
            return new CycleKindsToAudio() { Input = cycles };
        }
    }
}
