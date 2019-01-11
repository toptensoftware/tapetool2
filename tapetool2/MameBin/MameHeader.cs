using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.MameBin
{
/*
MAME QuickLoad .bin File Format

0xFD 0x00 0x80 0x00 0x00					// Not sure
<len.lsb> <len.msb>							// len = total length of the file (including headers) minus 1
0x00 0x00 0x00 0x00							// when reading could be more
<filename>									// up to 256 chars (ignore embedded null chars)
0x1A
<execaddr.lsb> <execaddr.msb>
<loadaddr.lsb> <loadaddr.msb>
<endaddr.lsb> <endaddr.msb>					// size = (endadd - loadaddr + 1) & 0xFFFF
[size x bytes load data]
*/



    public struct MameHeader
    {
        public string ProgramName;
        public ushort LoadAddress;
        public ushort LoadLength;
        public ushort ExecAddress;
    }
}
