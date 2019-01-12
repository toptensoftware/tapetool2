using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.MameBin;

namespace tapetool2.Sorcerer
{
    [Filter("sorcerer.blocksToMame", "Converts a Sorcerer Block Stream to MAME quickload bin format")]
    class BlocksToMame : CompositeStream, MameBin.IMameStream
    {
        public BlocksToMame()
        {
            Add(_unpacker = new UnpackData());
        }

        [InputStream]
        public IBlockStream Input
        {
            get { return _unpacker.Input; }
            set { _unpacker.Input = value; }
        }

        public MameHeader Header
        {
            get
            {
                return new MameHeader()
                {
                    ProgramName = _unpacker.Input.Header.filename.Trim(),
                    LoadAddress = _unpacker.Input.Header.loadaddr,
                    LoadLength = _unpacker.Input.Header.datalen,
                    ExecAddress = _unpacker.Input.Header.startaddr,
                };
            }
        }

        UnpackData _unpacker;

        public byte GetByte() => _unpacker.GetByte();
    }
}
