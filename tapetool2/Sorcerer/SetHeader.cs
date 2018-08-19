using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;


namespace tapetool2.Sorcerer
{
    [Filter("sorcerer.setHeader", "Updates the header in a Exidy Sorcerer block stream")]
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
        char? _fileid;
        char? _filetype;
        ushort? _datalen;
        ushort? _loadaddr;
        ushort? _startaddr;

        [FilterOption("filename", "Sets or overrides the header filename")]
        public string Filename
        {
            set { _filename = value; }
        }

        [FilterOption("fileId", "Sets or overrides the header file id")]
        public char FileId
        {
            set { _fileid = value; }
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

        public override void Rewind()
        {
            base.Rewind();


            // Start with the source header
            _header = _input.Header;

            // Apply changes
            if (_filename != null)
                _header.filename = _filename;
            if (_fileid.HasValue)
                _header.fileid = _fileid.Value;
            if (_filetype.HasValue)
                _header.filetype = _filetype.Value;
            if (_datalen.HasValue)
                _header.datalen = _datalen.Value;
            if (_loadaddr.HasValue)
                _header.loadaddr = _loadaddr.Value;
            if (_startaddr.HasValue)
                _header.startaddr = _startaddr.Value;
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

        public override IEnumerable<IStream> EnumStreams()
        {
            yield return _input;
        }

        protected override bool OnNext()
        {
            return _input.Next();
        }

        public override void WriteSummary(TextWriter w)
        {
            base.WriteSummary(w);
            w.WriteLine("    header: {0}", _header);
        }
    }
}

