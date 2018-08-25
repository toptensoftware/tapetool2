using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Trs80
{
    /*
    SYSTEM TAPE FORMAT
    TAPE LEADER             256 zeroes followed by a A5 (sync byte)
    55                      header byte indicating system format
    xx xx xx xx xx xx       6 character file name in ASCII

            3C              data header
            xx              length of data 01-FFH, 00=256 bytes
            lsb,msb         load address
            xx ... xx       data (your program)
            xx              checksum of your data & load address

            .               repeat from 3C through checksum
            .
            .
    78                      end of file marker
    lsb,msb                 entry point address
    */
    class SystemBlock : Block
    {
        public ushort Address { get; set; }
        public byte[] Data { get; set; }

        public byte Checksum
        {
            get
            {
                byte checksum = 0;
                checksum += (byte)(Address & 0xFF);
                checksum += (byte)((Address >> 8) & 0xFF);
                foreach (var b in Data)
                    checksum += b;
                return checksum;
            }
        }
    }

    class EntryPointAddressBlock : Block
    {
        public ushort EntryPoint { get; set; }
    }
}
