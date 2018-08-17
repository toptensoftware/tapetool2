using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Microbee
{
    [Filter("microbee.audioToBytes", "Parses an Microbee tape audio stream into a bytes")]
    class AudioToBytes : Kansas.AudioToBytes
    {
    }

    [Filter("microbee.audioToCycleKinds", "Generates Microbee audio cycles from an audio stream")]
    class AudioToCycleKinds : Kansas.AudioToCycleKinds
    {
    }


    [Filter("microbee.audioToHalfCycleKinds", "Generates Microbee audio half-cycles from an audio stream")]
    class AudioToHalfCycleKinds : Kansas.AudioToHalfCycleKinds
    {
    }

    [Filter("microbee.bitsToBytes", "Decodes a Microbee bit stream into byte stream")]
    class BitsToBytes : Kansas.BitsToBytes
    {
    }

    [Filter("microbee.bitsToCycleKinds", "Generates Microbee cycle kinds from a bit stream")]
    class BitsToCycleKinds : Kansas.BitsToCycleKinds
    {
    }

    [Filter("microbee.bytesToBits", "Encodes a byte stream into Microbee bit stream")]
    class BytesToBits : Kansas.BytesToBits
    {
    }

    [Filter("microbee.cycleKindsToAudio", "Generates Microbee audio cycles from a cycle kind stream")]
    class CycleKindsToAudio : Kansas.CycleKindsToAudio
    {
    }

    [Filter("microbee.halfCycleKindsToAudio", "Generates Microbee audio from a half-`cycle kind stream")]
    class HalfCycleKindsToAudio : Kansas.HalfCycleKindsToAudio
    {
    }

    [Filter("microbee.cycleKindsToBits", "Parses Microbee cycle kinds into a bit stream")]
    class CycleKindsToBits : Kansas.CycleKindsToBits
    {
    }


}
