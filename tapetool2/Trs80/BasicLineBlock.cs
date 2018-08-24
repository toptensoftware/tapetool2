using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tapetool2.Trs80
{
    /*
    BASIC TAPE FORMAT
    LEADER                  256 zeroes followed by an A5 (sync byte)
    D3 D3 D3                BASIC header bytes
    xx                      1 character file name in ASCII

            lsb,msb         address pointer to next line
            lsb,msb         line #
            xx ... xx       BASIC line (compressed)
            00              end of line marker

            .
            .
            .

    00 00                   end of file markers
    */
    class BasicBlock : Block
    {
        public ushort NextLineAddress { get; set; }
        public ushort LineNumber { get; set; }
        public string LineText { get; set; }


        public static string[] BasicKeywords = new string[]
        {
            "END",
            "FOR",
            "RESET",
            "SET",
            "CLS",
            "CMD",
            "RANDOM",
            "NEXT",
            "DATA",
            "INPUT",
            "DIM",
            "READ",
            "LET",
            "GOTO",
            "RUN",
            "IF",
            "RESTORE",
            "GOSUB",
            "RETURN",
            "REM",
            "STOP",
            "ELSE",
            "TRON",
            "TROFF",
            "DEFSTR",
            "DEFINT",
            "DEFSNG",
            "DEFDBL",
            "LINE",
            "EDIT",
            "ERROR",
            "RESUME",
            "OUT",
            "ON",
            "OPEN",
            "FIELD",
            "GET",
            "PUT",
            "CLOSE",
            "LOAD",
            "MERGE",
            "NAME",
            "KILL",
            "LSET",
            "RSET",
            "SAVE",
            "SYSTEM",
            "LPRINT",
            "DEF",
            "POKE",
            "PRINT",
            "CONT",
            "LIST",
            "LLIST",
            "DELETE",
            "AUTO",
            "CLEAR",
            "CLOAD",
            "CSAVE",
            "NEW",
            "TAB",
            "TO",
            "FN",
            "USING",
            "VARPTR",
            "USR",
            "ERL",
            "ERR",
            "STRING$",
            "INSTR",
            "POINT",
            "TIME$",
            "MEM",
            "INKEY$",
            "THEN",
            "NOT",
            "STEP",
            "+",
            "-",
            "*",
            "/",
            "<up>",
            "AND",
            "OR",
            ">",
            "=",
            "<",
            "SGN",
            "INT",
            "ABS",
            "FRE",
            "INP",
            "POS",
            "SQR",
            "RND",
            "LOG",
            "EXP",
            "COS",
            "SIN",
            "TAN",
            "ATN",
            "PEEK",
            "CVI",
            "CVS",
            "CVD",
            "EOF",
            "LOC",
            "LOF",
            "MKI$",
            "MKS$",
            "MKD$",
            "CINT",
            "CSNG",
            "CDBL",
            "FIX",
            "LEN",
            "STR$",
            "VAL",
            "ASC",
            "CHR$",
            "LEFT$",
            "RIGHT$",
            "MID$",
            "'",
            "",
            "",
            "",
            "",
        };
    }
}
