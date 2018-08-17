using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Sorcerer
{
    [Filter("sorcerer.audioToBytes", "Parses an Exidy Sorcerer tape audio stream into a bytes")]
    class AudioToBytes : Kansas.AudioToBytes
    {
    }

    [Filter("sorcerer.audioToCycleKinds", "Generates Exidy Sorcerer audio cycles from a cycle kind stream")]
    class AudioToCycleKinds : Kansas.AudioToCycleKinds
    {
    }

    [Filter("sorcerer.bitsToBytes", "Decodes a Exidy Sorcerer bit stream into byte stream")]
    class BitsToBytes : Kansas.BitsToBytes
    {
    }

    [Filter("sorcerer.bitsToCycleKinds", "Generates Exidy Sorcerer cycle kinds from a bit stream")]
    class BitsToCycleKinds : Kansas.BitsToCycleKinds
    {
    }

    [Filter("sorcerer.bytesToBits", "Encodes a byte stream into Exidy Sorcerer bit stream")]
    class BytesToBits : Kansas.BytesToBits
    {
    }

    [Filter("sorcerer.cycleKindsToAudio", "Generates Exidy Sorcerer audio cycles from a cycle kind stream")]
    class CycleKindsToAudio : Kansas.CycleKindsToAudio
    {
    }

    [Filter("sorcerer.cycleKindsToBits", "Parses Exidy Sorcerer cycle kinds into a bit stream")]
    class CycleKindsToBits : Kansas.CycleKindsToBits
    {
    }


}
