using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace tapetool2.Tape
{
    [FileReader("textCycleLengthReader", "Text cycle-length file reader", ".cyclelen.txt")]
    class TextCycleLengthReader : StreamBase, ICycleLengthStream
    {
        public TextCycleLengthReader()
        {
        }

        [FilterOption("filename", "The file to read", IsFileName = true)]
        public string Filename
        {
            get;
            set;
        }

        TextReader _reader;
        TextIntParser _parser;

        public override void Rewind()
        {
            // Base
            base.Rewind();

            Close();

            _reader = new StreamReader(Filename);
            _parser = new TextIntParser(_reader);

            // Consume the sample rate
            _sampleRate = _parser.Next().Value;
        }

        public override IEnumerable<IStream> EnumStreams()
        {
            yield break;
        }

        int _sampleRate;
        int? _currentCycleLength;

        public int SampleRate => _sampleRate;
        public int CurrentCycleLength => _currentCycleLength.Value;

        protected override bool OnNext()
        {
            _currentCycleLength = _parser.Next();
            return _currentCycleLength.HasValue;    
        }

        void Close()
        {
            if (_reader!=null)
            {
                _parser = null;
                _reader.Dispose();
                _reader = null;
            }
        }

        public override void Dispose()
        {
            Close();
            base.Dispose();
        }
    }
}     