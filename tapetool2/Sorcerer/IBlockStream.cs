using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Sorcerer
{

    public class Block
    {
        public ushort Address;
        public byte[] Data;
        public byte Checksum;
    }

    [StreamKind("Exidy Sorcerer block stream", "Exidy Sorcerer block stream")]
    interface IBlockStream : IStream
    {
        TapeHeader Header
        {
            get;
        }

        Block GetBlock();
    }
}
