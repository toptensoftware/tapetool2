using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.MameBin;

namespace tapetool2.Sorcerer
{
    [Filter("sorcerer.mameToBlocks", "Converts MAME quickload bin format to a Sorcerer Block Stream")]
    class MameToBlocks : CompositeStream, IBlockStream
    {
        public MameToBlocks()
        {
            Add(_packer = new PackData());
        }

        [InputStream]
        public IMameStream Input
        {
            get { return _packer.Input as IMameStream; }
            set { _packer.Input = value; }
        }

        TapeHeader IBlockStream.Header
        {
            get
            {
                return new TapeHeader()
                {
                    fileid = (char)0x55,
                    filetype = (char)0x4C,
                    filename = Input.Header.ProgramName,
                    loadaddr = Input.Header.LoadAddress,
                    datalen = Input.Header.LoadLength,
                    startaddr = Input.Header.ExecAddress,
                };
            }
        }

        PackData _packer;

        public override void Rewind()
        {
            base.Rewind();

            _packer.DataLen = Input.Header.LoadLength;
        }

        public Block GetBlock() => _packer.GetBlock();
    }
}
