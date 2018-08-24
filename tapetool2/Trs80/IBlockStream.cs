using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;

namespace tapetool2.Trs80
{
    enum FileType
    {
        System = 0x55,
        Text = 0xD3,
        Basic = 0xD3D3D3,
    }

    interface IBlockStream : IStream
    {
        string FileName { get; }
        FileType FileType { get; }
        Block GetBlock();
    }

    abstract class Block
    {
        public byte[] PackedBytes { get; set; }
    }

}
