using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2
{
    static class WaveUtils
    {
        public const uint ChunkIdRiff = 0x46464952;		//'RIFF'
        public const uint RiffTypeWave = 0x45564157;
        public const uint ChunkIdFmt = 0x20746d66;	    	//'fmt '
        public const uint ChunkIdData = 0x61746164;	    //'data'
        public const uint ChunkIdJunk = 0x6b6e756a;		//'junk'

        public enum Format
        {
            PCM = 1,
            FLOAT = 3,
            EXTENSIBLE = 0xFFFE,
        }
    }
}
