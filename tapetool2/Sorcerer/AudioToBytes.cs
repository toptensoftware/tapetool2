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
        public AudioToBytes()
        {
            cutoffFrequency = ((600 + 1200) / 2);
        }

        public override byte ReadBit()
        {
            // Only need special handling for 1200 baud
            if (_tapeSpeed != TAPE_SPEED_1200)
                return base.ReadBit();

            // Read one cycle
            int halfCycleLength = ReadHalfCycleLength();
            if (halfCycleLength < _cutOffSamples)
            {
                ReadHalfCycleLength();
                return 0x80;
            }
            else
            {
                return 0x00;
            }
        }

        protected override bool OnNext()
        {
            _currentByte = 0xFF;

            if (_eof)
                return false;

            // Skip any long cycles - should never happen as we should already be
            // in the tail cycles of the last byte, but this might help to resync
            while (ReadHalfCycleLength() >= _cutOffSamples)
            {
                // nop
            }

            // Skip short cycles at end of last byte
            while (ReadHalfCycleLength() < _cutOffSamples && !_eof)
            {
                // nop
            }

            // EOF?
            if (_eof)
                return false;

            var samplePos = ((StreamBase)_input).Position;

            // Read 8 bits
            for (int i = 0; i < 8; i++)
            {
                if (_eof)
                    return false;

                var sp = ((StreamBase)_input).Position;
                _currentByte = (byte)(ReadBit() | (_currentByte >> 1));
                if (Trace)
                    Console.WriteLine("Read bit {0:X2} from sample {1}", (_currentByte & 0x80) != 0 ? '1' : '0', sp);
            }

            if (Trace)
                Console.WriteLine("Read byte #{0} as {1:X2} from sample {2}", Position, _currentByte, samplePos);

            // Got the byte!
            return true;
        }

    }

}
