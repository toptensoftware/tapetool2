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

        public string filename
        {
            get { return Encoding.ASCII.GetString(_filename); }
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
    }
}
