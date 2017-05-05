using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;


namespace tapetool2.Microbee
{
    [Filter("microbee.setHeader", "Updates the header in a Microbee block stream")]
    class SetHeader : StreamBase, IBlockStream
    {
        public SetHeader()
        {
        }

        IBlockStream _input;

        [InputStream]
        public IBlockStream Input
        {
            get { return _input; }
            set { _input = value; }
        }


        // These properties override the values from source tap stream
        string _filename;
        char? _filetype;
        ushort? _datalen;
        ushort? _loadaddr;
        ushort? _startaddr;
        byte? _speed;
        byte? _autostart;

        [FilterOption("filename", "Sets or overrides the header filename")]
        public string Filename
        {
            set { _filename = value; }
        }

        [FilterOption("fileType", "Sets or overrides the header file type")]
        public char FileType
        {
            set { _filetype = value; }
        }

        [FilterOption("dataLen", "Sets or overrides the header data length")]
        public ushort DataLen
        {
            set { _datalen = value; }
        }

        [FilterOption("loadAddr", "Sets or overrides the header load address")]
        public ushort LoadAddress
        {
            set { _loadaddr = value; }
        }

        [FilterOption("startAddr", "Sets or overrides the header start address")]
        public ushort StartAddress
        {
            set { _startaddr = value; }
        }

        [FilterOption("speed", "Sets or overrides the header speed field")]
        public byte Speed
        {
            set { _speed = value; }
        }

        [FilterOption("autoStart", "Sets or overrides the header auto-start field")]
        public byte AutoStart
        {
            set { _autostart = value; }
        }


        public override void Rewind()
        {
            base.Rewind();


            // Start with the source header
            _header = _input.Header;

            // Apply changes
            if (_filename != null)
                _header.filename = _filename;
            if (_filetype.HasValue)
                _header.filetype = _filetype.Value;
            if (_datalen.HasValue)
                _header.datalen = _datalen.Value;
            if (_loadaddr.HasValue)
                _header.loadaddr = _loadaddr.Value;
            if (_startaddr.HasValue)
                _header.startaddr = _startaddr.Value;
            if (_speed.HasValue)
                _header.speed = _speed.Value;
            if (_autostart.HasValue)
                _header.autostart = _autostart.Value;

        }

        TapeHeader _header;

        public TapeHeader Header
        {
            get
            {
                return _header;
            }
        }

        public Block GetBlock()
        {
            return _input.GetBlock();
        }

        public override IEnumerable<IStream> GetPrecedents()
        {
            yield return _input;
        }

        public override bool Next()
        {
            return _input.Next();
        }

    }
}

