using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Audio;
using tapetool2.Binary;
using tapetool2.Tape;

namespace tapetool2.Sorcerer
{
    class StreamConversions
    {
#if NO
        [StreamConverter]
        public static IBlockStream ConvertTapToBlocks(TapFileReader reader)
        {
            return new BytesToBlocks() { Input = reader };
        }

#endif

        [StreamConverter]
        public static IAudioStream ConvertBlocksToAudio(IBlockStream blocks)
        {
            return new RenderAudio() { Input = blocks };
        }

#if NO
        [StreamConverter]
        public static IAudioStream ConvertTapFileToAudio(TapFileReader reader)
        {
            return new RenderAudio() { Input = new BytesToBlocks() { Input = reader } };
        }

#endif

        [StreamConverter]
        public static IBlockStream ConvertAudioToBlocks(IAudioStream audio)
        {
            return new ParseAudio() { Input = audio };
        }


#if NO
        [StreamConverter(TargetObjectType = typeof(TapFileWriter))]
        public static IByteStream ConvertAudioToTapFile(IAudioStream audio)
        {
            return new BlocksToBytes() { Input = new ParseAudio() { Input = audio } };
        }
#endif

        [StreamConverter(Namespace = "sorcerer")]
        public static IHalfCycleKindStream ConvertAudioToHalfCycleKinds(IAudioStream audio)
        {
            return new AudioToHalfCycleKinds() { Input = audio };
        }

        [StreamConverter(Namespace = "sorcerer")]
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

        [StreamConverter(Namespace = "sorcerer")]
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

        [StreamConverter(Namespace="sorcerer")]
        public static IAudioStream ConvertHalfCycleKindsToAudio(IHalfCycleKindStream cycles)
        {
            return new HalfCycleKindsToAudio() { Input = cycles };
        }

        [StreamConverter(Namespace = "sorcerer")]
        public static MameBin.IMameStream ConvertBlocksToMameStream(IBlockStream stream)
        {
            return new BlocksToMame() { Input = stream };
        }

        [StreamConverter(Namespace = "sorcerer")]
        public static IBlockStream ConvertMameStreamToBlocks(MameBin.IMameStream stream)
        {
            return new MameToBlocks() { Input = stream };
        }
    }
}
