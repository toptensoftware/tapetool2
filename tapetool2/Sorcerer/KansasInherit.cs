using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Sorcerer
{
    [Filter("sorcerer.audioToHalfCycleKinds", "Generates Exidy Sorcerer audio half-cycles from an audio stream")]
    class AudioToHalfCycleKinds : Kansas.AudioToHalfCycleKinds
    {
        public AudioToHalfCycleKinds()
        {
            SetFormatSpec(Kansas.FormatSpec.Sorcerer);
        }
    }

    [Filter("sorcerer.bitsToBytes", "Decodes a Exidy Sorcerer bit stream into byte stream")]
    class BitsToBytes : Kansas.BitsToBytes
    {
    }

    [Filter("sorcerer.bitsToHalfCycleKinds", "Generates Kansas City half-cycle kinds from a bit stream")]
    class BitsToHalfCycleKinds : Kansas.BitsToHalfCycleKinds
    {
        public BitsToHalfCycleKinds()
        {
            SetFormatSpec(Kansas.FormatSpec.Sorcerer);
        }
    }

    [Filter("sorcerer.bytesToBits", "Encodes a byte stream into Exidy Sorcerer bit stream")]
    class BytesToBits : Kansas.BytesToBits
    {
        public BytesToBits()
        {
            SetFormatSpec(Kansas.FormatSpec.Sorcerer);
        }
    }

    [Filter("sorcerer.halfCycleKindsToAudio", "Generates Exidy Sorcerer audio from a half-cycle kind stream")]
    class HalfCycleKindsToAudio : Kansas.HalfCycleKindsToAudio
    {
        public HalfCycleKindsToAudio()
        {
            SetFormatSpec(Kansas.FormatSpec.Sorcerer);
        }
    }


    /*
    [Filter("sorcerer.cycleKindsToBits", "Parses Exidy Sorcerer cycle kinds into a bit stream")]
    class CycleKindsToBits : Kansas.CycleKindsToBits
    {
    }
    */


}
