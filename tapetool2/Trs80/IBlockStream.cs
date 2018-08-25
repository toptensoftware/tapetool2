using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;

namespace tapetool2.Trs80
{
    public enum FileType
    {
        System = 0x55,
        Text = 0xD3,
        Basic = 0xD3D3D3,
    }

    public class Header
    {
        public string FileName { get; set; }
        public FileType FileType { get; set; }

        public byte[] FileTypeBytes
        {
            get
            {
                switch (FileType)
                {
                    case FileType.System: return new byte[] { 0x55 };
                    case FileType.Text: return new byte[] { 0xd3 };
                    case FileType.Basic: return new byte[] { 0xd3, 0xd3, 0xd3 };
                }
                throw new NotImplementedException();
            }
        }

        public byte[] FileNameBytes
        {
            get
            {
                return FileName.Select(x => (byte)x).ToArray();
            }
        }

        public byte[] Bytes
        {
            get
            {
                return FileTypeBytes.Concat(FileNameBytes).ToArray();
            }
        }
    }

    interface IBlockStream : IStream
    {
        Header Header { get; }
        Block CurrentBlock { get; }
    }

    abstract class Block
    {
        public byte[] PackedBytes { get; set; }
    }

}
