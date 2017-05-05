using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Microbee
{

    public class Block
    {
        public ushort Address;
        public byte[] Data;
        public byte Checksum;
    }

    [StreamKind("Microbee block stream", "Microbee block stream")]
    interface IBlockStream : IStream
    {
        TapeHeader Header
        {
            get;
        }

        Block GetBlock();
    }
}
