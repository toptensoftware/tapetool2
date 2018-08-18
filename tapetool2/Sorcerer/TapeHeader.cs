using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Sorcerer
{
    [StructLayout(LayoutKind.Sequential, Pack = 1, CharSet = CharSet.Ansi)]
    unsafe struct TapeHeader
    {
        // https://archive.org/stream/bitsavers_exidySorcer79_5914238/Sorcerer_Software_Manual_Apr79#page/n21
        [MarshalAs(UnmanagedType.ByValArray, SizeConst = 5)]
        public byte[] _filename;
        public char fileid;               // Usually 0x55
        public char filetype;
        public ushort datalen;
        public ushort loadaddr;
        public ushort startaddr;
        public byte unused1;
        public byte unused2;
        public byte unused;

        public override string ToString()
        {
            return string.Format("name:'{0}',id:'{1}',type:'{2}',datalen:0x{3:X4},load:0x{4:X4},start:0x{5:X4}",
                filename, fileid, filetype, datalen, loadaddr, startaddr);
        }

        public string filename
        {
            get
            {
                if (_filename == null)
                    return null;
                return Encoding.ASCII.GetString(_filename);
            }
            set
            {
                _filename = Encoding.ASCII.GetBytes((value + "      ").Substring(0, 5));
            }
        }

        public static TapeHeader FromBytes(byte[] bytes)
        {
            System.Diagnostics.Debug.Assert(Marshal.SizeOf<TapeHeader>() == 16);

            // Unpack it
            unsafe
            {
                fixed (byte* pHeader = bytes)
                {
                    return Marshal.PtrToStructure<TapeHeader>((IntPtr)pHeader);
                }
            }
        }

        public byte[] ToBytes()
        {
            var bytes = new byte[16];
            // Unpack it
            unsafe
            {
                fixed (byte* pHeader = bytes)
                {
                    Marshal.StructureToPtr<TapeHeader>(this, (IntPtr)pHeader, false);
                }
            }
            return bytes;
        }

        public byte Checksum
        {
            get
            {
                byte checksum = 0;
                foreach (var data in ToBytes())
                {
                    checksum = (byte)(0xFF - (byte)(data - checksum));
                }
                return checksum;
            }
        }
    }
}
