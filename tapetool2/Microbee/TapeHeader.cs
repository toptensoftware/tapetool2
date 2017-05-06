using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Microbee
{
    [StructLayout(LayoutKind.Sequential, Pack = 1, CharSet = CharSet.Ansi)]
    unsafe struct TapeHeader
    {
        [MarshalAs(UnmanagedType.ByValArray, SizeConst = 6)]
        public byte[] _filename;
        public char filetype;
        public ushort datalen;
        public ushort loadaddr;
        public ushort startaddr;
        public byte speed;
        public byte autostart;
        public byte unused;

        public override string ToString()
        {
            return string.Format("name:'{0}',type:'{1}',datalen:0x{2:X4},load:0x{3:X4},start:0x{4:X4},speed:0x{5:X2},auto:0x{6:X2}",
                filename, filetype, datalen, loadaddr, startaddr, speed, autostart);
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
                _filename = Encoding.ASCII.GetBytes((value + "      ").Substring(0, 6));
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
                return (byte)(0x100 - (byte)(ToBytes().Select(x => (int)x).Sum() + 16));
            }
        }
    }
}
