using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tapetool2.Binary;

namespace tapetool2.Sorcerer
{
    [StreamKind("Exidy Sorcerer tap stream", "Exidy Sorcerer tap stream")]
    interface ITapStream : IByteStream
    {
        TapeHeader Header
        {
            get;
        }
    }
}
