using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Trs80
{
    /*
    EDITOR/ASSEMBLER SOURCE TAPE FORMAT
    TAPE LEADER             256 zeroes followed by a A5 (sync byte)
    D3                      header byte indicating source format
    xx xx xx xx xx xx       6 character file name in ASCII

            xx xx xx xx xx  line # in ASCII with bit 7 set in each byte
            20              data header
            xx ... xx       source line (128 byte maximum)
            0D              end of line marker

            .
            .
            .

    1A                      end of file marker
    */
    class TextBlock : Block
    {
        public int LineNumber { get; set; }
        public string LineText { get; set; }
    }
}
