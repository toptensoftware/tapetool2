
        ORG     0100h

        ; --- START PROC L0100 ---
L0100:  JP      L0D71

L0103:  DB      0C3h
        DB      0Eh
        DB      0Fh
        DB      0C3h
        DB      96h
        DB      0Ch
        DB      0C3h
L010A:  DB      90h
        DB      09h
        DB      0C3h
        DB      53h             ; 'S'
        DB      0Ah
        DB      0C3h
        DB      7Eh             ; '~'
        DB      0Ah

        ; --- START PROC L0112 ---
L0112:  JP      L0AF8

L0115:  DB      0C3h
        DB      61h             ; 'a'
        DB      0Ch

        ; --- START PROC L0118 ---
L0118:  JP      L0CEA

        ; --- START PROC L011B ---
L011B:  JP      L0D24

        ; --- START PROC L011E ---
L011E:  JP      L1529

L0121:  DB      0C3h
        DB      0Eh
        DB      15h
        DB      0C3h
L0125:  DB      0EEh
        DB      13h

        ; --- START PROC L0127 ---
L0127:  JP      L122A

L012A:  DB      0C3h
        DB      0E0h
        DB      11h
        DB      0C3h
        DB      69h             ; 'i'
        DB      01h

        ; --- START PROC L0130 ---
L0130:  JP      L0527

        ; --- START PROC L0133 ---
L0133:  JP      L0525

        ; --- START PROC L0136 ---
L0136:  JP      L0516

        ; --- START PROC L0139 ---
L0139:  JP      L0594

L013C:  DB      0C3h
        DB      0F3h
        DB      05h

        ; --- START PROC L013F ---
L013F:  JP      L04FE

        ; --- START PROC L0142 ---
L0142:  JP      L0502

L0145:  DB      0C3h
        DB      54h             ; 'T'
        DB      08h

        ; --- START PROC L0148 ---
L0148:  JP      L085E

        ; --- START PROC L014B ---
L014B:  LD      BC,0DD4Eh
        LD      (HL),02h
        ; Entry Point
        ; --- START PROC L0150 ---
L0150:  DI
        LD      A,01h
        LD      B,01h
        CP      70h             ; 'p'
        JR      Z,L015E
L0159:  LD      SP,17D7h
        LD      B,00h
L015E:  LD      A,B
        CALL    L05F3
        LD      (L15D2),A
        OR      A
        CALL    NZ,L014B
        CALL    L060C
        LD      (L0159+2),HL    ; reference not aligned to instruction
        CALL    L08BC
        CALL    L018F
        CALL    L05F3
        CALL    L0112
        JR      L0186

L017D:  CALL    L06E4
        CALL    L0100
        CALL    L067C
L0186:  SUB     A
        LD      (L175C),A
        CALL    L0100
        JR      L017D

        ; --- START PROC L018F ---
L018F:  CALL    L05F3
        LD      HL,01CDh
        CALL    L0516
        LD      HL,(L16F7)
        CALL    L085E
        LD      HL,01FDh
        CALL    L0516
        LD      HL,(L16F3)
        CALL    L085E
        LD      IX,(L1753)
        LD      BC,0FFFDh
        ADD     IX,BC
        LD      A,(IX+01h)
        LD      (IX+02h),A
        LD      A,(IX+00h)
        LD      (IX+01h),A
        LD      (IX+00h),2Eh    ; '.'
        LD      HL,0208h
        CALL    L0516
        CALL    L0594
        RET

L01CD:  DB      2Ah             ; '*'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      44h             ; 'D'
        DB      56h             ; 'V'
        DB      45h             ; 'E'
        DB      4Eh             ; 'N'
        DB      54h             ; 'T'
        DB      55h             ; 'U'
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      20h             ; ' '
        DB      2Ah             ; '*'
        DB      20h             ; ' '
        DB      28h             ; '('
        DB      56h             ; 'V'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      73h             ; 's'
        DB      69h             ; 'i'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      3Ah             ; ':'
        DB      20h             ; ' '
        DB      38h             ; '8'
        DB      2Eh             ; '.'
        DB      32h             ; '2'
        DB      29h             ; ')'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      64h             ; 'd'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      75h             ; 'u'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Eh             ; 'n'
        DB      75h             ; 'u'
        DB      6Dh             ; 'm'
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      3Ah             ; ':'
        DB      20h             ; ' '
        DB      00h
        DB      28h             ; '('
        DB      56h             ; 'V'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      73h             ; 's'
        DB      69h             ; 'i'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      3Ah             ; ':'
        DB      20h             ; ' '
        DB      00h
        DB      29h             ; ')'
        DB      43h             ; 'C'
        DB      6Fh             ; 'o'
        DB      70h             ; 'p'
        DB      79h             ; 'y'
        DB      72h             ; 'r'
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      68h             ; 'h'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      64h             ; 'd'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      31h             ; '1'
        DB      39h             ; '9'
        DB      37h             ; '7'
        DB      39h             ; '9'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      42h             ; 'B'
        DB      6Fh             ; 'o'
        DB      78h             ; 'x'
        DB      20h             ; ' '
        DB      33h             ; '3'
        DB      34h             ; '4'
        DB      33h             ; '3'
        DB      35h             ; '5'
        DB      20h             ; ' '
        DB      4Ch             ; 'L'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      77h             ; 'w'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      64h             ; 'd'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      46h             ; 'F'
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      69h             ; 'i'
        DB      64h             ; 'd'
        DB      61h             ; 'a'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      55h             ; 'U'
        DB      2Eh             ; '.'
        DB      53h             ; 'S'
        DB      2Eh             ; '.'
        DB      41h             ; 'A'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      0Dh
        DB      0Dh
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      54h             ; 'T'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      70h             ; 'p'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      67h             ; 'g'
        DB      72h             ; 'r'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      41h             ; 'A'
        DB      64h             ; 'd'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      75h             ; 'u'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      22h             ; '"'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      76h             ; 'v'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      6Dh             ; 'm'
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      69h             ; 'i'
        DB      72h             ; 'r'
        DB      21h             ; '!'
        DB      20h             ; ' '
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      72h             ; 'r'
        DB      73h             ; 's'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      72h             ; 'r'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      0Dh
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      6Ch             ; 'l'
        DB      64h             ; 'd'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      59h             ; 'Y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      62h             ; 'b'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      4Ch             ; 'L'
        DB      4Fh             ; 'O'
        DB      4Fh             ; 'O'
        DB      4Bh             ; 'K'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      54h             ; 'T'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      50h             ; 'P'
        DB      49h             ; 'I'
        DB      43h             ; 'C'
        DB      4Bh             ; 'K'
        DB      2Dh             ; '-'
        DB      55h             ; 'U'
        DB      50h             ; 'P'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      65h             ; 'e'
        DB      0Dh
        DB      4Dh             ; 'M'
        DB      41h             ; 'A'
        DB      4Eh             ; 'N'
        DB      49h             ; 'I'
        DB      50h             ; 'P'
        DB      55h             ; 'U'
        DB      4Ch             ; 'L'
        DB      41h             ; 'A'
        DB      54h             ; 'T'
        DB      45h             ; 'E'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      62h             ; 'b'
        DB      6Ah             ; 'j'
        DB      65h             ; 'e'
        DB      63h             ; 'c'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      59h             ; 'Y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      73h             ; 's'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      62h             ; 'b'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      0Dh
        DB      54h             ; 'T'
        DB      52h             ; 'R'
        DB      41h             ; 'A'
        DB      56h             ; 'V'
        DB      45h             ; 'E'
        DB      4Ch             ; 'L'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      63h             ; 'c'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      69h             ; 'i'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      63h             ; 'c'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      69h             ; 'i'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      70h             ; 'p'
        DB      75h             ; 'u'
        DB      70h             ; 'p'
        DB      70h             ; 'p'
        DB      65h             ; 'e'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      0Dh
        DB      41h             ; 'A'
        DB      64h             ; 'd'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      75h             ; 'u'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      59h             ; 'Y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      20h             ; ' '
        DB      32h             ; '2'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      45h             ; 'E'
        DB      4Eh             ; 'N'
        DB      47h             ; 'G'
        DB      4Ch             ; 'L'
        DB      49h             ; 'I'
        DB      53h             ; 'S'
        DB      48h             ; 'H'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      63h             ; 'c'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      27h             ; '''
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      0Dh
        DB      6Fh             ; 'o'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      31h             ; '1'
        DB      32h             ; '2'
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      76h             ; 'v'
        DB      6Fh             ; 'o'
        DB      63h             ; 'c'
        DB      61h             ; 'a'
        DB      62h             ; 'b'
        DB      75h             ; 'u'
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      6Eh             ; 'n'
        DB      27h             ; '''
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      6Bh             ; 'k'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      72h             ; 'r'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      21h             ; '!'
        DB      0Dh
        DB      53h             ; 'S'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      6Bh             ; 'k'
        DB      6Eh             ; 'n'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      3Ah             ; ':'
        DB      20h             ; ' '
        DB      48h             ; 'H'
        DB      45h             ; 'E'
        DB      4Ch             ; 'L'
        DB      50h             ; 'P'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      53h             ; 'S'
        DB      41h             ; 'A'
        DB      56h             ; 'V'
        DB      45h             ; 'E'
        DB      20h             ; ' '
        DB      47h             ; 'G'
        DB      41h             ; 'A'
        DB      4Dh             ; 'M'
        DB      45h             ; 'E'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      53h             ; 'S'
        DB      43h             ; 'C'
        DB      4Fh             ; 'O'
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      4Eh             ; 'N'
        DB      56h             ; 'V'
        DB      45h             ; 'E'
        DB      4Eh             ; 'N'
        DB      54h             ; 'T'
        DB      4Fh             ; 'O'
        DB      52h             ; 'R'
        DB      59h             ; 'Y'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      51h             ; 'Q'
        DB      55h             ; 'U'
        DB      49h             ; 'I'
        DB      54h             ; 'T'
        DB      2Eh             ; '.'
        DB      0Dh
        DB      0Dh
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      54h             ; 'T'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      75h             ; 'u'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      79h             ; 'y'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      70h             ; 'p'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      67h             ; 'g'
        DB      72h             ; 'r'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      0Dh
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      75h             ; 'u'
        DB      72h             ; 'r'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      6Ch             ; 'l'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      72h             ; 'r'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      64h             ; 'd'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      75h             ; 'u'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      50h             ; 'P'
        DB      4Ch             ; 'L'
        DB      45h             ; 'E'
        DB      41h             ; 'A'
        DB      53h             ; 'S'
        DB      45h             ; 'E'
        DB      21h             ; '!'
        DB      0Dh
        DB      0Dh
        DB      44h             ; 'D'
        DB      4Fh             ; 'O'
        DB      4Eh             ; 'N'
        DB      27h             ; '''
        DB      54h             ; 'T'
        DB      20h             ; ' '
        DB      43h             ; 'C'
        DB      4Fh             ; 'O'
        DB      50h             ; 'P'
        DB      59h             ; 'Y'
        DB      20h             ; ' '
        DB      4Fh             ; 'O'
        DB      52h             ; 'R'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      43h             ; 'C'
        DB      43h             ; 'C'
        DB      45h             ; 'E'
        DB      50h             ; 'P'
        DB      54h             ; 'T'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      50h             ; 'P'
        DB      49h             ; 'I'
        DB      52h             ; 'R'
        DB      41h             ; 'A'
        DB      54h             ; 'T'
        DB      45h             ; 'E'
        DB      44h             ; 'D'
        DB      22h             ; '"'
        DB      20h             ; ' '
        DB      43h             ; 'C'
        DB      4Fh             ; 'O'
        DB      50h             ; 'P'
        DB      59h             ; 'Y'
        DB      20h             ; ' '
        DB      4Fh             ; 'O'
        DB      46h             ; 'F'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      44h             ; 'D'
        DB      56h             ; 'V'
        DB      45h             ; 'E'
        DB      4Eh             ; 'N'
        DB      54h             ; 'T'
        DB      55h             ; 'U'
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      21h             ; '!'
        DB      0Dh
        DB      0Dh
        DB      48h             ; 'H'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      54h             ; 'T'
        DB      55h             ; 'U'
        DB      52h             ; 'R'
        DB      4Eh             ; 'N'
        DB      00h

        ; --- START PROC L04FE ---
L04FE:  PUSH    AF
        PUSH    HL
        JR      L0506

        ; --- START PROC L0502 ---
L0502:  PUSH    AF
        LD      A,(HL)
        PUSH    HL
        INC     HL
        ; --- START PROC L0506 ---
L0506:  OR      A
        JR      Z,L0513
        DEC     A
        PUSH    AF
        LD      A,(HL)
        INC     HL
        CALL    L0527
        POP     AF
        JR      L0506

L0513:  POP     HL
        POP     AF
        RET

        ; --- START PROC L0516 ---
L0516:  PUSH    HL
        PUSH    AF
L0518:  LD      A,(HL)
        OR      A
        JR      Z,L0522
        CALL    L0527
        INC     HL
        JR      L0518

L0522:  POP     AF
        POP     HL
        RET

        ; --- START PROC L0525 ---
L0525:  LD      A,0Dh
        ; --- START PROC L0527 ---
L0527:  OR      A
        RET     Z
        PUSH    AF
        PUSH    HL
        PUSH    DE
        PUSH    BC
        LD      C,00h
        LD      HL,(L1753)
        CP      0Dh
        JR      Z,L053A
        CP      0Ah
        JR      NZ,L0540
L053A:  LD      A,L
        OR      3Fh             ; '?'
        LD      L,A
        JR      L0547

L0540:  LD      (HL),A
        CP      (HL)
        JR      Z,L0547
        SUB     20h             ; ' '
        LD      (HL),A
L0547:  INC     HL
        LD      (L1753),HL
        LD      A,L
        AND     3Fh             ; '?'
        JR      NZ,L0551
        INC     C
L0551:  SCF
        CCF
        LD      DE,0F800h
        SBC     HL,DE
        JP      M,L057F
        LD      HL,0F7C0h
        LD      DE,(L16F9)
        SCF
        CCF
        SBC     HL,DE
        JP      M,L0579
        JR      Z,L0579
        PUSH    HL
        POP     BC
        LD      HL,(L16F9)
        PUSH    HL
        LD      DE,0040h
        ADD     HL,DE
        POP     DE
        LDIR
        INC     C
L0579:  LD      HL,0F7C0h
        LD      (L1753),HL
L057F:  DEC     C
        JR      NZ,L058F
        LD      HL,(L1753)
        PUSH    HL
        POP     DE
        INC     DE
        LD      (HL),20h        ; ' '
        LD      BC,003Fh
        LDIR
L058F:  POP     BC
        POP     DE
        POP     HL
        POP     AF
        RET

        ; --- START PROC L0594 ---
L0594:  PUSH    AF
        LD      BC,0019h
        LD      HL,15D3h
        LD      DE,15D4h
        LD      (HL),00h
        LDIR
        LD      B,18h
        LD      IX,15D3h
L05A8:  LD      HL,(L1753)
        LD      (HL),5Fh        ; '_'
L05AD:  LD      DE,00A0h
L05B0:  PUSH    DE
        CALL    0E018h
        POP     DE
        OR      A
        JR      NZ,L05C6
        DEC     DE
        LD      A,D
        OR      E
        JR      NZ,L05B0
        LD      A,(HL)
        CP      20h             ; ' '
        JR      Z,L05A8
        LD      (HL),20h        ; ' '
        JR      L05AD

L05C6:  CP      7Fh             ; ''
        LD      HL,(L1753)
        LD      (HL),20h        ; ' '
        JR      NZ,L05E3
        DEC     HL
        LD      (HL),20h        ; ' '
        LD      A,B
        CP      18h
        JR      Z,L05A8
        INC     B
        DEC     IX
        LD      (IX+00h),00h
        LD      (L1753),HL
        JR      L05A8

L05E3:  CALL    L0527
        CP      0Dh
        JR      Z,L05F1
        LD      (IX+00h),A
        INC     IX
        DJNZ    L05A8
L05F1:  POP     AF
        RET

        ; --- START PROC L05F3 ---
L05F3:  EXX
        LD      DE,0F081h
        LD      HL,0F080h
        LD      (L1753),HL
        LD      BC,077Fh
        LD      (HL),20h        ; ' '
        LDIR
        LD      HL,0F100h
        LD      (L16F9),HL
        EXX
        RET

        ; --- START PROC L060C ---
L060C:  LD      DE,(L15C6)
        LD      HL,(L170F)
        INC     HL
        ADD     HL,HL
        PUSH    HL
        POP     BC
        LD      HL,(L15CA)
        LDIR
        LD      HL,(L1717)
        LD      (L1789),HL
        LD      HL,(L171B)
        LD      (L17A1),HL
        LD      HL,1769h
        LD      DE,176Ah
        LD      BC,001Fh
        LD      (HL),00h
        LDIR
        SUB     A
        LD      (L171D),A
        RET

        ; --- START PROC L063A ---
L063A:  LD      DE,(L170B)
        INC     DE
        LD      D,E
        LD      E,00h
L0642:  LD      A,(L1709)
        LD      B,A
        LD      IX,1720h
        INC     HL
L064B:  LD      A,(IX+00h)
        CP      (HL)
        JR      NZ,L0674
        INC     IX
        INC     HL
        DJNZ    L064B
L0656:  LD      BC,(L1709)
        INC     BC
        SCF
        CCF
        SBC     HL,BC
        LD      A,(HL)
        CP      2Ah             ; '*'
        JR      NZ,L0667
        DEC     E
        JR      L0656

L0667:  PUSH    DE
        LD      DE,1720h
        LD      BC,(L1709)
        INC     HL
        LDIR
        POP     DE
        RET

L0674:  INC     HL
        DJNZ    L0674
        INC     E
        DEC     D
        RET     Z
        JR      L0642

        ; --- START PROC L067C ---
L067C:  LD      HL,(L15C6)
        LD      BC,0012h
        ADD     HL,BC
        LD      A,(HL)
        OR      A
        RET     Z
        LD      HL,(L17A1)
        DEC     HL
        LD      (L17A1),HL
        LD      A,H
        OR      A
        RET     NZ
        LD      A,L
        LD      HL,06D1h
        OR      A
        RET     M
        JR      NZ,L06A0
        CPL
        LD      (L1779),A
        CALL    L0516
        RET

L06A0:  CP      19h
        RET     P
        LD      HL,06B6h
        CALL    L0516
        LD      HL,(L17A1)
        CALL    L085E
        LD      HL,06C9h
        CALL    L0516
        RET

L06B6:  DB      4Ch             ; 'L'
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      68h             ; 'h'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      72h             ; 'r'
        DB      75h             ; 'u'
        DB      6Eh             ; 'n'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      00h
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      75h             ; 'u'
        DB      72h             ; 'r'
        DB      6Eh             ; 'n'
        DB      73h             ; 's'
        DB      0Dh
        DB      00h
        DB      4Ch             ; 'L'
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      68h             ; 'h'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      72h             ; 'r'
        DB      75h             ; 'u'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      74h             ; 't'
        DB      0Dh
        DB      00h

        ; --- START PROC L06E4 ---
L06E4:  LD      HL,07CDh
        CALL    L0516
        CALL    L0594
        LD      IY,15D3h
        CALL    L082A
        LD      A,(L1721)
        OR      A
        JR      NZ,L0750
        LD      A,(L1720)
        LD      HL,171Dh
        LD      B,(HL)
        CP      58h             ; 'X'
        LD      (HL),00h
        RET     Z
        LD      (HL),01h
        CP      70h             ; 'p'
        RET     Z
        LD      (HL),02h
        CP      74h             ; 't'
        RET     Z
        LD      (HL),B
        CP      49h             ; 'I'
        JR      NZ,L0727
        LD      IX,1720h
        LD      (IX+01h),4Eh    ; 'N'
        LD      (IX+02h),56h    ; 'V'
        LD      (IX+03h),45h    ; 'E'
        JR      L0750

L0727:  LD      B,01h
        CP      4Eh             ; 'N'
        JR      Z,L0746
        INC     B
        CP      53h             ; 'S'
        JR      Z,L0746
        INC     B
        CP      45h             ; 'E'
        JR      Z,L0746
        INC     B
        CP      57h             ; 'W'
        JR      Z,L0746
        INC     B
        CP      55h             ; 'U'
        JR      Z,L0746
        INC     B
        CP      44h             ; 'D'
        JR      NZ,L0750
L0746:  LD      A,B
        LD      (L175E),A
        LD      A,01h
        LD      (L175C),A
        RET

L0750:  LD      HL,(L15D0)
        CALL    L063A
        JR      NZ,L076D
        LD      HL,07EDh
        CALL    L0516
        LD      HL,1720h
        CALL    L0516
        LD      HL,0803h
        CALL    L0516
        JP      L06E4

L076D:  LD      A,E
        LD      (L175C),A
        CALL    L082A
        SUB     A
        LD      (L175E),A
        LD      A,(L1720)
        OR      A
        JR      Z,L079F
        LD      HL,(L15CE)
        CALL    L063A
        LD      A,E
        LD      (L175E),A
        JR      NZ,L079F
        LD      HL,0810h
        CALL    L0516
        LD      HL,1720h
        CALL    L0516
        LD      HL,0824h
        CALL    L0516
        JP      L06E4

L079F:  LD      A,(IY+00h)
        INC     IY
        OR      A
        RET     Z
        CP      20h             ; ' '
        JR      Z,L079F
        LD      HL,07B3h
        CALL    L0516
        JP      L06E4

L07B3:  DB      55h             ; 'U'
        DB      73h             ; 's'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Eh             ; 'n'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      32h             ; '2'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      64h             ; 'd'
        DB      73h             ; 's'
        DB      0Dh
        DB      00h
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      2Dh             ; '-'
        DB      2Dh             ; '-'
        DB      2Dh             ; '-'
        DB      2Dh             ; '-'
        DB      2Dh             ; '-'
        DB      2Dh             ; '-'
        DB      2Dh             ; '-'
        DB      3Eh             ; '>'
        DB      20h             ; ' '
        DB      54h             ; 'T'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      3Fh             ; '?'
        DB      20h             ; ' '
        DB      00h
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      27h             ; '''
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      6Bh             ; 'k'
        DB      6Eh             ; 'n'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      00h
        DB      22h             ; '"'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      0Dh
        DB      00h
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      27h             ; '''
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      6Bh             ; 'k'
        DB      6Eh             ; 'n'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      00h
        DB      22h             ; '"'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      0Dh
        DB      00h

        ; --- START PROC L082A ---
L082A:  LD      DE,1721h
        LD      HL,1720h
        LD      (HL),00h
        LD      BC,0018h
        LDIR
        LD      IX,1720h
        SUB     A
L083C:  EX      AF,AF'
        LD      A,(IY+00h)
        INC     IY
        OR      A
        RET     Z
        CP      20h             ; ' '
        JR      NZ,L084D
        EX      AF,AF'
        OR      A
        JR      Z,L083C
        RET

L084D:  LD      (IX+00h),A
        INC     IX
        JR      L083C

L0854:  DB      29h             ; ')'
        DB      0D5h
        DB      0EDh
        DB      5Bh             ; '['
        DB      0C6h
        DB      15h
        DB      19h
        DB      0D1h
        DB      7Eh             ; '~'
        DB      0C9h

        ; --- START PROC L085E ---
L085E:  PUSH    HL
        PUSH    AF
        PUSH    IX
        PUSH    DE
        PUSH    BC
        PUSH    HL
        LD      BC,0005h
        LD      DE,1757h
        LD      HL,1756h
        LD      (HL),00h
        LDIR
        POP     HL
        SUB     A
        CP      H
        JR      Z,L0888
        JP      M,L0888
        LD      A,2Dh           ; '-'
        LD      (L1756),A
        PUSH    HL
        POP     BC
        LD      HL,0000h
        SCF
        CCF
        SBC     HL,BC
L0888:  LD      IX,175Bh
        PUSH    HL
        LD      B,05h
L088F:  POP     DE
        LD      HL,000Ah
        CALL    L011E
        LD      A,E
        OR      30h             ; '0'
        LD      (IX+00h),A
        SUB     A
        CP      H
        JR      NZ,L08A3
        CP      L
        JR      Z,L08AA
L08A3:  NOP
        DEC     IX
        PUSH    HL
        DJNZ    L088F
        POP     HL
L08AA:  LD      HL,1755h
        CALL    L0502
        LD      A,20h           ; ' '
        CALL    L0527
        POP     BC
        POP     DE
        POP     IX
        POP     AF
        POP     HL
        RET

        ; --- START PROC L08BC ---
L08BC:  LD      HL,0929h
        CALL    L0516
        CALL    L0594
        LD      A,(L15D3)
        CP      4Eh             ; 'N'
        RET     Z
        CP      59h             ; 'Y'
        JR      NZ,L08BC
        CALL    L0118
        CALL    L0953
        LD      DE,(L16F7)
        LD      HL,(L15D3)
        SCF
        CCF
        SBC     HL,DE
        LD      HL,091Ah
        CALL    NZ,L0516
        PUSH    AF
        CALL    NZ,L011B
        POP     AF
        JR      NZ,L08BC
        LD      DE,1767h
        LD      BC,003Ch
        LD      HL,15D5h
        LDIR
        CALL    L0953
        CALL    L011B
        LD      A,(L170F)
        LD      B,A
        INC     B
        LD      IY,(L15C6)
        LD      IX,15D3h
L090B:  LD      A,(IX+00h)
        LD      (IY+00h),A
        INC     IY
        INC     IY
        INC     IX
        DJNZ    L090B
        RET

L091A:  DB      42h             ; 'B'
        DB      41h             ; 'A'
        DB      44h             ; 'D'
        DB      20h             ; ' '
        DB      53h             ; 'S'
        DB      41h             ; 'A'
        DB      56h             ; 'V'
        DB      45h             ; 'E'
        DB      20h             ; ' '
        DB      46h             ; 'F'
        DB      49h             ; 'I'
        DB      4Ch             ; 'L'
        DB      45h             ; 'E'
        DB      0Dh
        DB      00h
        DB      57h             ; 'W'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      70h             ; 'p'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      76h             ; 'v'
        DB      69h             ; 'i'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      73h             ; 's'
        DB      6Ch             ; 'l'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      3Fh             ; '?'
        DB      20h             ; ' '
        DB      00h

        ; --- START PROC L0953 ---
L0953:  LD      A,(L15D2)
        OR      A
        LD      DE,16D3h
        PUSH    AF
        CALL    NZ,4436h
        POP     AF
        RET     NZ
        SUB     A
        CALL    L098C
        LD      IX,15D3h
        CALL    L097B
        LD      B,00h
L096D:  CALL    0E00Fh
        LD      (IX+00h),A
        INC     IX
        DJNZ    L096D
        CALL    L097A
        ; --- START PROC L097A ---
L097A:  RET

        ; --- START PROC L097B ---
L097B:  LD      B,32h           ; '2'
L097D:  CALL    0E00Fh
        OR      A
        JR      NZ,L097B
        DJNZ    L097D
L0985:  CALL    0E00Fh
        OR      A
        JR      Z,L0985
        RET

        ; --- START PROC L098C ---
L098C:  SUB     A
        OUT     (0FEh),A
        RET

L0990:  DB      0B8h
        DB      09h
        DB      0D2h
        DB      09h
        DB      0E1h
        DB      09h
        DB      0EAh
        DB      09h
        DB      0F5h
        DB      09h
        DB      05h
        DB      0Ah
        DB      15h
        DB      0Ah
        DB      23h             ; '#'
        DB      0Ah
        DB      31h             ; '1'
        DB      0Ah
        DB      3Dh             ; '='
        DB      0Ah
        DB      0B9h
        DB      09h
        DB      0BDh
        DB      09h
        DB      0D7h
        DB      09h
        DB      0E6h
        DB      09h
        DB      0F1h
        DB      09h
        DB      0FAh
        DB      09h
        DB      09h
        DB      0Ah
        DB      1Ah
        DB      0Ah
        DB      28h             ; '('
        DB      0Ah
        DB      49h             ; 'I'
        DB      0Ah
        DB      0C9h
        DB      0Eh
        DB      0FFh
        DB      18h
        DB      02h
        DB      0Eh
        DB      00h
        DB      2Ah             ; '*'
        DB      0C6h
        DB      15h
        DB      3Ah             ; ':'
        DB      0Fh
        DB      17h
        DB      47h             ; 'G'
        DB      7Eh             ; '~'
        DB      0FEh
        DB      0FFh
        DB      0C8h
        DB      23h             ; '#'
        DB      23h             ; '#'
        DB      10h
        DB      0F8h
        DB      79h             ; 'y'
        DB      2Fh             ; '/'
        DB      4Fh             ; 'O'
        DB      0C9h
        DB      0FEh
        DB      0FFh
        DB      0C8h
        DB      18h
        DB      0Ch
        DB      0Eh
        DB      00h
        DB      0FEh
        DB      0FFh
        DB      0C8h
        DB      0BEh
        DB      0C8h
        DB      0Eh
        DB      0FFh
        DB      0C9h
        DB      0BEh
        DB      0C8h
        DB      0Eh
        DB      00h
        DB      0C9h
        DB      0B7h
        DB      0C0h
        DB      18h
        DB      0F9h
        DB      0BEh
        DB      0C8h
        DB      0FEh
        DB      0FFh
        DB      0C8h
        DB      18h
        DB      0F2h
        DB      0B7h
        DB      0C8h
        DB      18h
        DB      0EEh
        DB      7Bh             ; '{'
        DB      0BEh
        DB      0C8h
        DB      18h
        DB      0E9h
        DB      2Ah             ; '*'
        DB      67h             ; 'g'
        DB      17h
        DB      37h             ; '7'
        DB      3Fh             ; '?'
        DB      0EDh
        DB      52h             ; 'R'
        DB      0F8h
        DB      0C8h
        DB      18h
        DB      0DEh
        DB      0BEh
        DB      0C0h
        DB      18h
        DB      0DAh
        DB      2Ah             ; '*'
        DB      67h             ; 'g'
        DB      17h
        DB      37h             ; '7'
        DB      3Fh             ; '?'
        DB      0EDh
        DB      52h             ; 'R'
        DB      28h             ; '('
        DB      0D1h
        DB      0F0h
        DB      18h
        DB      0CEh
        DB      0FEh
        DB      0FFh
        DB      0C0h
        DB      18h
        DB      0C9h
        DB      2Ah             ; '*'
        DB      0CAh
        DB      15h
        DB      19h
        DB      19h
        DB      0BEh
        DB      0C8h
        DB      18h
        DB      0C0h
        DB      7Bh             ; '{'
        DB      0BEh
        DB      0C0h
        DB      18h
        DB      0BBh
        DB      2Ah             ; '*'
        DB      0CAh
        DB      15h
        DB      19h
        DB      19h
        DB      0BEh
        DB      0C0h
        DB      18h
        DB      0B2h
        DB      0EBh
        DB      0D5h
        DB      11h
        DB      69h             ; 'i'
        DB      17h
        DB      19h
        DB      0D1h
        DB      7Eh             ; '~'
        DB      0B7h
        DB      0C0h
        DB      18h
        DB      0A6h
        DB      0EBh
        DB      0D5h
        DB      11h
        DB      69h             ; 'i'
        DB      17h
        DB      19h
        DB      0D1h
        DB      7Eh             ; '~'
        DB      0B7h
        DB      0C8h
        DB      18h
        DB      9Ah
        DB      2Ah             ; '*'
        DB      67h             ; 'g'
        DB      17h
        DB      37h             ; '7'
        DB      3Fh             ; '?'
        DB      0EDh
        DB      52h             ; 'R'
        DB      0C8h
        DB      18h
        DB      90h
        DB      0F5h
        DB      0D5h
        DB      0E5h
        DB      0C5h
        DB      0DDh
        DB      0E5h
        DB      0FDh
        DB      0E5h
        DB      0CDh
        DB      33h             ; '3'
        DB      01h
        DB      21h             ; '!'
        DB      0CBh
        DB      0Ah
        DB      0CDh
        DB      36h             ; '6'
        DB      01h
        DB      0EDh
        DB      4Bh             ; 'K'
        DB      0Fh
        DB      17h
        DB      03h
        DB      41h             ; 'A'
        DB      0DDh
        DB      2Ah             ; '*'
        DB      0C6h
        DB      15h
        DB      0FDh
        DB      2Ah             ; '*'
        DB      0C8h
        DB      15h
        DB      97h
        DB      08h
        DB      0DDh
        DB      7Eh             ; '~'
        DB      00h
        DB      0FEh
        DB      0FFh
        DB      0CCh
        DB      7Eh             ; '~'
        DB      0Ah
        DB      18h
        DB      2Fh             ; '/'

        ; --- START PROC L0A7E ---
L0A7E:  LD      L,(IY+00h)
        LD      H,(IY+01h)
        PUSH    BC
        LD      B,(HL)
        INC     HL
        LD      A,(L1753)
        AND     3Fh             ; '?'
        ADD     A,02h
        ADD     A,B
        CP      40h             ; '@'
        CALL    P,L0133
L0A94:  LD      A,(HL)
        CP      2Fh             ; '/'
        JR      Z,L0A9F
        CALL    L0130
        INC     HL
        DJNZ    L0A94
L0A9F:  LD      A,2Eh           ; '.'
        CALL    L0130
        EX      AF,AF'
        LD      A,20h           ; ' '
        CALL    L0130
        EX      AF,AF'
        POP     BC
        RET

L0AAD:  DB      0DDh
        DB      23h             ; '#'
        DB      0DDh
        DB      23h             ; '#'
        DB      0FDh
        DB      23h             ; '#'
        DB      0FDh
        DB      23h             ; '#'
        DB      10h
        DB      0BDh
        DB      21h             ; '!'
        DB      0E9h
        DB      0Ah
        DB      08h
        DB      0B7h
        DB      0CCh
        DB      36h             ; '6'
        DB      01h
        DB      0CDh
        DB      33h             ; '3'
        DB      01h
        DB      0FDh
        DB      0E1h
        DB      0DDh
        DB      0E1h
        DB      0C1h
        DB      0E1h
        DB      0D1h
        DB      0F1h
        DB      0C9h
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      72h             ; 'r'
        DB      79h             ; 'y'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      6Fh             ; 'o'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      3Ah             ; ':'
        DB      0Dh
        DB      00h
        DB      4Eh             ; 'N'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      00h

        ; --- START PROC L0AF8 ---
L0AF8:  PUSH    AF
        EXX
        PUSH    IX
        PUSH    IY
        LD      HL,(L16F9)
        LD      BC,0F41h
        ADD     HL,BC
        PUSH    HL
        POP     BC
        LD      HL,0F0C0h
        LD      (L1753),HL
        LD      DE,0F0C1h
        LD      (HL),20h        ; ' '
        LDIR
        LD      A,(L1778)
        OR      A
        JR      Z,L0B33
        LD      HL,(L15C6)
        LD      DE,0012h
        ADD     HL,DE
        LD      A,(HL)
        CP      0FFh
        JR      Z,L0B33
        LD      HL,1789h
        CP      (HL)
        LD      HL,0BEAh
        CALL    NZ,L0136
        JP      NZ,L0BC4
L0B33:  LD      HL,(L15B6)
        LD      BC,(L1789)
        ADD     HL,BC
        ADD     HL,BC
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        LD      A,(DE)
        LD      B,A
        INC     DE
        LD      A,(DE)
        CP      2Ah             ; '*'
        JR      NZ,L0B4B
        DEC     B
        INC     DE
        JR      L0B51

L0B4B:  LD      HL,0C00h
        CALL    L0136
L0B51:  EX      DE,HL
        LD      A,B
        CALL    L013F
        LD      A,(L170F)
        LD      B,A
        INC     B
        LD      C,00h
        LD      IX,(L15C6)
        LD      IY,(L15C8)
L0B65:  LD      A,(L1789)
        CP      (IX+00h)
        JR      NZ,L0B79
        LD      A,C
        OR      A
        LD      HL,0C2Fh
        CALL    Z,L0136
        INC     C
        CALL    L0A7E
L0B79:  INC     IY
        INC     IY
        INC     IX
        INC     IX
        DJNZ    L0B65
        CALL    L0133
        LD      C,00h
        LD      B,06h
        LD      IX,15B8h
        LD      DE,0C0Bh
L0B91:  LD      L,(IX+00h)
        LD      H,(IX+01h)
        PUSH    BC
        LD      BC,(L1789)
        ADD     HL,BC
        ADD     HL,BC
        POP     BC
        LD      A,(HL)
        OR      A
        JR      Z,L0BB1
        LD      A,C
        OR      A
        LD      HL,0C42h
        CALL    Z,L0136
        INC     C
        PUSH    DE
        POP     HL
        CALL    L0136
L0BB1:  INC     IX
        INC     IX
L0BB5:  LD      A,(DE)
        OR      A
        JR      Z,L0BBC
        INC     DE
        JR      L0BB5

L0BBC:  INC     DE
        DJNZ    L0B91
        SUB     A
        CP      C
        CALL    NZ,L0133
L0BC4:  LD      A,3Ch           ; '<'
        CALL    L0130
        LD      B,3Eh           ; '>'
        LD      A,2Dh           ; '-'
L0BCD:  CALL    L0130
        DJNZ    L0BCD
        LD      A,3Eh           ; '>'
        CALL    L0130
        LD      HL,(L1753)
        LD      (L16F9),HL
        POP     IY
        POP     IX
        LD      HL,0F7C0h
        LD      (L1753),HL
        EXX
        POP     AF
        RET

L0BEA:  DB      49h             ; 'I'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      6Bh             ; 'k'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      21h             ; '!'
        DB      0Dh
        DB      00h
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      00h
        DB      4Eh             ; 'N'
        DB      4Fh             ; 'O'
        DB      52h             ; 'R'
        DB      54h             ; 'T'
        DB      48h             ; 'H'
        DB      20h             ; ' '
        DB      00h
        DB      53h             ; 'S'
        DB      4Fh             ; 'O'
        DB      55h             ; 'U'
        DB      54h             ; 'T'
        DB      48h             ; 'H'
        DB      20h             ; ' '
        DB      00h
        DB      45h             ; 'E'
        DB      41h             ; 'A'
        DB      53h             ; 'S'
        DB      54h             ; 'T'
        DB      20h             ; ' '
        DB      00h
        DB      57h             ; 'W'
        DB      45h             ; 'E'
        DB      53h             ; 'S'
        DB      54h             ; 'T'
        DB      20h             ; ' '
        DB      00h
        DB      55h             ; 'U'
        DB      50h             ; 'P'
        DB      20h             ; ' '
        DB      00h
        DB      44h             ; 'D'
        DB      4Fh             ; 'O'
        DB      57h             ; 'W'
        DB      4Eh             ; 'N'
        DB      20h             ; ' '
        DB      00h
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      56h             ; 'V'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      69h             ; 'i'
        DB      62h             ; 'b'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      6Dh             ; 'm'
        DB      73h             ; 's'
        DB      3Ah             ; ':'
        DB      0Dh
        DB      0Dh
        DB      00h
        DB      0Dh
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      53h             ; 'S'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      62h             ; 'b'
        DB      76h             ; 'v'
        DB      69h             ; 'i'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      65h             ; 'e'
        DB      78h             ; 'x'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      3Ah             ; ':'
        DB      20h             ; ' '
        DB      00h
        DB      0F5h
        DB      0FDh
        DB      0E5h
        DB      0D5h
        DB      0FDh
        DB      21h             ; '!'
        DB      0ACh
        DB      15h
        DB      0EDh
        DB      5Bh             ; '['
        DB      07h
        DB      17h
        DB      0FDh
        DB      19h
        DB      0FDh
        DB      19h
        DB      13h
        DB      0EDh
        DB      53h             ; 'S'
        DB      07h
        DB      17h
        DB      0FDh
        DB      5Eh             ; '^'
        DB      00h
        DB      0FDh
        DB      56h             ; 'V'
        DB      01h
        DB      0DDh
        DB      0E5h
        DB      0E1h
        DB      29h             ; ')'
        DB      19h
        DB      5Eh             ; '^'
        DB      23h             ; '#'
        DB      56h             ; 'V'
        DB      21h             ; '!'
        DB      14h
        DB      00h
        DB      0CDh
        DB      1Eh
        DB      01h
        DB      97h
        DB      0BAh
        DB      20h             ; ' '
        DB      0D7h
        DB      0BBh
        DB      20h             ; ' '
        DB      0D4h
        DB      0D1h
        DB      0FDh
        DB      0E1h
        DB      0F1h
        DB      0C9h
        DB      0DDh
        DB      0E5h
        DB      0FDh
        DB      0E5h
        DB      21h             ; '!'
        DB      0DDh
        DB      0Ch
        DB      0CDh
        DB      36h             ; '6'
        DB      01h
        DB      0CDh
        DB      0EAh
        DB      0Ch
        DB      2Ah             ; '*'
        DB      0F7h
        DB      16h
        DB      22h             ; '"'
        DB      0D3h
        DB      15h
        DB      11h
        DB      0D5h
        DB      15h
        DB      21h             ; '!'
        DB      67h             ; 'g'
        DB      17h
        DB      01h
        DB      3Ch             ; '<'
        DB      00h
        DB      0EDh
        DB      0B0h
        DB      0CDh
        DB      2Fh             ; '/'
        DB      0Dh
        DB      3Ah             ; ':'
        DB      0Fh
        DB      17h
        DB      47h             ; 'G'
        DB      04h
        DB      0DDh
        DB      21h             ; '!'
        DB      0D3h
        DB      15h
        DB      0FDh
        DB      2Ah             ; '*'
        DB      0C6h
        DB      15h
        DB      0FDh
        DB      7Eh             ; '~'
        DB      00h
        DB      0DDh
        DB      77h             ; 'w'
        DB      00h
        DB      0FDh
        DB      23h             ; '#'
        DB      0FDh
        DB      23h             ; '#'
        DB      0DDh
        DB      23h             ; '#'
        DB      10h
        DB      0F2h
        DB      0CDh
        DB      2Fh             ; '/'
        DB      0Dh
        DB      0CDh
        DB      24h             ; '$'
        DB      0Dh
        DB      0FDh
        DB      0E1h
        DB      0DDh
        DB      0E1h
        DB      0C9h
        DB      53h             ; 'S'
        DB      41h             ; 'A'
        DB      56h             ; 'V'
        DB      49h             ; 'I'
        DB      4Eh             ; 'N'
        DB      47h             ; 'G'
        DB      20h             ; ' '
        DB      47h             ; 'G'
        DB      41h             ; 'A'
        DB      4Dh             ; 'M'
        DB      45h             ; 'E'
        DB      0Dh
        DB      00h

        ; --- START PROC L0CEA ---
L0CEA:  LD      HL,0D0Ch
        LD      A,(L15D2)
        OR      A
        CALL    Z,L0136
        CALL    Z,L0139
        RET     Z
        LD      HL,15D3h
        LD      B,00h
        LD      DE,16D3h
        CALL    4420h
        RET     Z
        OR      80h
        CALL    4490h
        JP      402Dh

L0D0C:  DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      41h             ; 'A'
        DB      44h             ; 'D'
        DB      59h             ; 'Y'
        DB      20h             ; ' '
        DB      54h             ; 'T'
        DB      41h             ; 'A'
        DB      50h             ; 'P'
        DB      45h             ; 'E'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      48h             ; 'H'
        DB      49h             ; 'I'
        DB      54h             ; 'T'
        DB      20h             ; ' '
        DB      45h             ; 'E'
        DB      4Eh             ; 'N'
        DB      54h             ; 'T'
        DB      45h             ; 'E'
        DB      52h             ; 'R'
        DB      2Eh             ; '.'
        DB      00h

        ; --- START PROC L0D24 ---
L0D24:  LD      A,(L15D2)
        OR      A
        LD      DE,16D3h
        CALL    NZ,4428h
        RET

L0D2F:  DB      3Ah             ; ':'
        DB      0D2h
        DB      15h
        DB      0B7h
        DB      28h             ; '('
        DB      0Fh
        DB      11h
        DB      0D3h
        DB      16h
        DB      0CDh
        DB      3Ch             ; '<'
        DB      44h             ; 'D'
        DB      0C8h
        DB      0F6h
        DB      80h
        DB      0CDh
        DB      09h
        DB      44h             ; 'D'
        DB      0C3h
        DB      2Dh             ; '-'
        DB      40h             ; '@'
        DB      97h
        DB      0CDh
        DB      6Bh             ; 'k'
        DB      0Dh
        DB      0CDh
        DB      5Fh             ; '_'
        DB      0Dh
        DB      0DDh
        DB      21h             ; '!'
        DB      0D3h
        DB      15h
        DB      06h
        DB      00h
        DB      0DDh
        DB      7Eh             ; '~'
        DB      00h
        DB      0CDh
        DB      12h
        DB      0E0h
        DB      0DDh
        DB      23h             ; '#'
        DB      10h
        DB      0F6h
        DB      0CDh
        DB      5Eh             ; '^'
        DB      0Dh
        DB      0C9h
        DB      97h
        DB      47h             ; 'G'
        DB      0CDh
        DB      12h
        DB      0E0h
        DB      10h
        DB      0FBh
        DB      3Ch             ; '<'
        DB      0CDh
        DB      12h
        DB      0E0h
        DB      0C9h
        DB      97h
        DB      0D3h
        DB      0FEh
        DB      0C9h
        DB      15h
L0D70:  DB      70h             ; 'p'

        ; --- START PROC L0D71 ---
L0D71:  SUB     A
        LD      (L1764),A
        LD      (L1763),A
        CPL
        LD      (L1762),A
        LD      (L1760),A
        LD      A,(L175C)
        CP      01h
        JR      NZ,L0D8F
        LD      A,(L175E)
        CP      07h
        CALL    M,L10ED
        RET     M
L0D8F:  LD      IX,0FFFFh
L0D93:  INC     IX
        PUSH    IX
        POP     HL
        SCF
        CCF
        LD      BC,(L170D)
        DEC     HL
        SBC     HL,BC
        JR      NZ,L0DC0
L0DA3:  LD      A,(L175C)
        OR      A
        RET     Z
        CALL    L0F84
        LD      HL,0F1Fh
        LD      A,(L1760)
        OR      A
        CALL    NZ,L0136
        LD      HL,0F5Eh
        LD      A,(L1762)
        OR      A
        CALL    Z,L0136
        RET

L0DC0:  PUSH    IX
        POP     HL
        LD      BC,(L15A0)
        ADD     HL,BC
        LD      A,(HL)
        LD      (L1766),A
        PUSH    IX
        POP     HL
        LD      BC,(L15A2)
        ADD     HL,BC
        LD      A,(HL)
        LD      (L1765),A
        LD      A,(L175C)
        OR      A
        JR      NZ,L0DE3
        LD      A,(L1766)
        OR      A
        RET     NZ
L0DE3:  LD      A,(L1764)
        OR      A
        JR      Z,L0DFD
        LD      A,(L1765)
        OR      A
        JR      NZ,L0DF5
        LD      A,(L1766)
        OR      A
        JR      Z,L0E3A
L0DF5:  LD      A,(L175C)
        OR      A
        RET     NZ
        LD      (L1764),A
L0DFD:  LD      A,(L175C)
        LD      HL,1766h
        CP      (HL)
        JR      NZ,L0D93
        OR      A
        JR      NZ,L0E1C
        SUB     A
        LD      (L1760),A
        CALL    L10E0
        LD      HL,1765h
        CP      (HL)
        JR      Z,L0E3A
        JP      M,L0E3A
        JP      L0D93

L0E1C:  LD      A,(L1765)
        LD      HL,175Eh
        CP      (HL)
        JR      Z,L0E29
        OR      A
        JP      NZ,L0D93
L0E29:  LD      A,(L171D)
        CP      01h
        LD      HL,0F7Dh
        CALL    Z,L0136
        PUSH    IX
        POP     HL
        CALL    Z,L0148
L0E3A:  SUB     A
        LD      (L1760),A
        LD      HL,0FFFFh
        LD      (L1762),HL
        LD      IY,15ACh
        LD      B,05h
L0E4A:  PUSH    BC
        LD      L,(IY+00h)
        LD      H,(IY+01h)
        PUSH    HL
        PUSH    IX
        POP     HL
        ADD     HL,HL
        POP     BC
        ADD     HL,BC
        LD      A,(HL)
        LD      E,A
        INC     HL
        LD      A,(HL)
        LD      D,A
        LD      HL,0014h
        CALL    L011E
        EX      DE,HL
        ADD     HL,HL
        PUSH    DE
        LD      DE,(L010A)
        ADD     HL,DE
        POP     DE
        LD      A,(HL)
        LD      (L0E80+1),A     ; reference not aligned to instruction
        INC     HL
        LD      A,(HL)
        LD      (L0E80+2),A     ; reference not aligned to instruction
        LD      HL,(L15C6)
        ADD     HL,DE
        ADD     HL,DE
        LD      A,(HL)
        LD      HL,1789h
        LD      C,0FFh
L0E80:  CALL    0000h
        LD      A,C
        LD      HL,1762h
        AND     (HL)
        LD      (HL),A
        INC     IY
        INC     IY
        POP     BC
        JP      Z,L0D93
        DEC     B
        JP      NZ,L0E4A
        LD      A,(L171D)
        OR      A
        LD      HL,0F77h
        CALL    NZ,L0136
        PUSH    IX
        POP     HL
        CALL    NZ,L0148
        LD      HL,0000h
        LD      (L1707),HL
        LD      IY,15A4h
        LD      B,04h
L0EB1:  PUSH    BC
        LD      L,(IY+00h)
        LD      H,(IY+01h)
        PUSH    IX
        POP     DE
        ADD     HL,DE
        LD      A,(HL)
        LD      (L0D70),A
        OR      A
        JR      Z,L0F07
        JP      M,L0ED0
        CP      34h             ; '4'
        JP      M,L0ED2
        CP      66h             ; 'f'
        JP      M,L0EE6
L0ED0:  SUB     32h             ; '2'
L0ED2:  LD      HL,(L15C4)
        LD      E,A
        LD      D,00h
        ADD     HL,DE
        ADD     HL,DE
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        EX      DE,HL
        CALL    L0142
        CALL    L0133
        JR      L0F07

L0EE6:  SUB     34h             ; '4'
        LD      E,A
        LD      D,00h
        PUSH    IX
        LD      IX,012Bh
        LD      L,(IX+00h)
        LD      H,(IX+01h)
        POP     IX
        ADD     HL,DE
        ADD     HL,DE
        LD      A,(HL)
        LD      (L0F04+1),A     ; reference not aligned to instruction
        INC     HL
        LD      A,(HL)
        LD      (L0F04+2),A     ; reference not aligned to instruction
L0F04:  CALL    0000h
L0F07:  POP     BC
        INC     IY
        INC     IY
        DJNZ    L0EB1
        LD      A,(L1764)
        OR      A
        JP      NZ,L0D93
        LD      A,(L175C)
        OR      A
        JP      NZ,L0DA3
        JP      L0D93

L0F1F:  DB      0Dh
        DB      4Ch             ; 'L'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      75h             ; 'u'
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      72h             ; 'r'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      73h             ; 's'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      75h             ; 'u'
        DB      74h             ; 't'
        DB      75h             ; 'u'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      2Eh             ; '.'
        DB      6Bh             ; 'k'
        DB      2Eh             ; '.'
        DB      3Fh             ; '?'
        DB      0Dh
        DB      00h
        DB      0Dh
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      27h             ; '''
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      79h             ; 'y'
        DB      65h             ; 'e'
        DB      74h             ; 't'
        DB      21h             ; '!'
        DB      0Dh
        DB      00h
        DB      44h             ; 'D'
        DB      49h             ; 'I'
        DB      44h             ; 'D'
        DB      3Ah             ; ':'
        DB      20h             ; ' '
        DB      00h
        DB      50h             ; 'P'
        DB      53h             ; 'S'
        DB      42h             ; 'B'
        DB      4Ch             ; 'L'
        DB      3Ah             ; ':'
        DB      20h             ; ' '
        DB      00h

        ; --- START PROC L0F84 ---
L0F84:  LD      A,(L175C)
        CP      0Ah
        JR      Z,L0F8E
        CP      12h
        RET     NZ
L0F8E:  LD      A,(L1763)
        OR      A
        RET     NZ
        LD      A,(L175E)
        OR      A
        JR      NZ,L0FA2
        LD      HL,1073h
        CALL    L0136
        JP      L1046

L0FA2:  LD      A,(L175C)
        CP      0Ah
        JR      NZ,L0FBA
        CALL    L0127
        LD      A,(L1715)
        DEC     A
        CP      C
        LD      HL,(L0125)
        CALL    M,L0136
        JP      M,L1046
L0FBA:  SUB     A
        EX      AF,AF'
        LD      IX,(L15C8)
        LD      L,(IX+00h)
        LD      H,(IX+01h)
        LD      BC,(L17A3)
        EXX
L0FCB:  EXX
        INC     HL
        DEC     BC
        LD      A,B
        OR      A
        JP      M,L104B
        JR      NZ,L0FD8
        CP      C
        JR      Z,L104B
L0FD8:  LD      A,2Fh           ; '/'
        CPIR
        JR      NZ,L104B
        LD      IX,1720h
        PUSH    HL
        POP     IY
        EXX
        LD      A,(L1709)
        LD      B,A
L0FEA:  LD      A,(IX+00h)
        OR      A
        JR      Z,L0FFB
        CP      (IY+00h)
        JR      NZ,L0FCB
        INC     IY
        INC     IX
        DJNZ    L0FEA
L0FFB:  LD      A,(IY+00h)
        CP      2Fh             ; '/'
        JR      NZ,L0FCB
        LD      E,(IY+01h)
        LD      D,00h
        LD      HL,(L15C6)
        ADD     HL,DE
        ADD     HL,DE
        LD      A,(L175C)
        CP      0Ah
        JR      Z,L1024
        LD      A,(HL)
        CP      0FFh
        JR      Z,L101E
        EX      AF,AF'
        LD      A,01h
L101B:  EX      AF,AF'
        JR      L0FCB

L101E:  LD      A,(L1789)
        LD      (HL),A
        JR      L103D

L1024:  LD      A,(HL)
        CP      0FFh
        JR      NZ,L102E
        EX      AF,AF'
        LD      A,04h
        JR      L101B

L102E:  PUSH    HL
        LD      HL,1789h
        CP      (HL)
        POP     HL
        JR      Z,L103B
        EX      AF,AF'
        LD      A,02h
        JR      L101B

L103B:  LD      (HL),0FFh
L103D:  LD      HL,1079h
        CALL    L0136
        CALL    L0112
L1046:  SUB     A
        LD      (L1760),A
        RET

L104B:  EX      AF,AF'
        LD      HL,107Dh
        CP      01h
        CALL    Z,L0136
        LD      HL,1093h
        CP      02h
        CALL    Z,L0136
        LD      HL,10AAh
        CP      04h
        CALL    Z,L0136
        OR      A
        JR      NZ,L1046
        LD      A,(L1763)
        RET     NZ
        LD      HL,10BEh
        CALL    L0136
        JR      L1046

L1073:  DB      48h             ; 'H'
        DB      55h             ; 'U'
        DB      48h             ; 'H'
        DB      3Fh             ; '?'
        DB      0Dh
        DB      00h
        DB      4Fh             ; 'O'
        DB      4Bh             ; 'K'
        DB      0Dh
        DB      00h
        DB      49h             ; 'I'
        DB      27h             ; '''
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      6Eh             ; 'n'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      72h             ; 'r'
        DB      79h             ; 'y'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      21h             ; '!'
        DB      0Dh
        DB      00h
        DB      0Dh
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      27h             ; '''
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      2Eh             ; '.'
        DB      0Dh
        DB      00h
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      64h             ; 'd'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      2Eh             ; '.'
        DB      0Dh
        DB      00h
        DB      0Dh
        DB      49h             ; 'I'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      70h             ; 'p'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      2Eh             ; '.'
        DB      0Dh
        DB      00h

        ; --- START PROC L10E0 ---
L10E0:  LD      A,R
        JP      M,L10E0
        JR      Z,L10E0
        CP      65h             ; 'e'
        RET     M
        LD      A,32h           ; '2'
        RET

        ; --- START PROC L10ED ---
L10ED:  PUSH    AF
        LD      C,01h
        LD      A,(L1778)
        OR      A
        JR      Z,L1110
        LD      HL,(L15C6)
        LD      DE,0012h
        ADD     HL,DE
        LD      A,(HL)
        CP      0FFh
        JR      Z,L1110
        LD      HL,1789h
        CP      (HL)
        JR      Z,L1110
        LD      C,00h
        LD      HL,1184h
        CALL    L0136
L1110:  LD      A,(L175E)
        DEC     A
        LD      HL,11A8h
        CALL    M,L0136
        JP      M,L115F
        LD      L,A
        LD      H,00h
        ADD     HL,HL
        LD      DE,15B8h
        ADD     HL,DE
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        EX      DE,HL
        LD      DE,(L1789)
        ADD     HL,DE
        ADD     HL,DE
        EX      DE,HL
        LD      HL,11C1h
        LD      A,(DE)
        OR      A
        JR      NZ,L1153
        DEC     C
        CALL    Z,L0136
        JR      Z,L115F
        LD      HL,1161h
        CALL    L0136
        LD      HL,1778h
        LD      (HL),00h
        LD      A,(L1713)
        LD      (L1789),A
        CALL    L0112
        JR      L115F

L1153:  LD      (L1789),A
        LD      HL,1079h
        CALL    L0136
        CALL    L0112
L115F:  POP     AF
        RET

L1161:  DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      26h             ; '&'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      63h             ; 'c'
        DB      6Bh             ; 'k'
        DB      21h             ; '!'
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      27h             ; '''
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      44h             ; 'D'
        DB      45h             ; 'E'
        DB      41h             ; 'A'
        DB      44h             ; 'D'
        DB      21h             ; '!'
        DB      0Dh
        DB      00h
        DB      49h             ; 'I'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      6Fh             ; 'o'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      6Bh             ; 'k'
        DB      21h             ; '!'
        DB      0Dh
        DB      00h
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      69h             ; 'i'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      63h             ; 'c'
        DB      74h             ; 't'
        DB      69h             ; 'i'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      0Dh
        DB      0Dh
        DB      00h
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      27h             ; '''
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      54h             ; 'T'
        DB      48h             ; 'H'
        DB      41h             ; 'A'
        DB      54h             ; 'T'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      69h             ; 'i'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      63h             ; 'c'
        DB      74h             ; 't'
        DB      69h             ; 'i'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      0Dh
        DB      00h
        DB      0C3h
        DB      3Eh             ; '>'
        DB      12h
        DB      60h             ; '`'
        DB      12h
        DB      7Bh             ; '{'
        DB      12h
        DB      0A6h
        DB      12h
        DB      0B8h
        DB      12h
        DB      0E2h
        DB      12h
        DB      34h             ; '4'
        DB      13h
        DB      0A6h
        DB      12h
        DB      50h             ; 'P'
        DB      13h
        DB      5Ah             ; 'Z'
        DB      13h
        DB      79h             ; 'y'
        DB      13h
        DB      95h
        DB      13h
        DB      0B0h
        DB      13h
        DB      1Ah
        DB      14h
        DB      0D7h
        DB      14h
        DB      0DBh
        DB      14h
        DB      0E1h
        DB      14h
        DB      0E7h
        DB      14h
        DB      0FDh
        DB      14h
        DB      6Eh             ; 'n'
        DB      12h
        DB      85h
        DB      12h
        DB      0B2h
        DB      12h
        DB      54h             ; 'T'
        DB      12h
        DB      0FEh
        DB      14h
        DB      0B0h
        DB      13h
        DB      0BDh
        DB      12h
        DB      0C5h
        DB      12h
        DB      0CCh
        DB      12h
        DB      0D3h
        DB      12h
        DB      0E7h
        DB      12h
        DB      07h
        DB      13h
        DB      13h
        DB      13h
        DB      23h             ; '#'
        DB      13h
        DB      2Ah             ; '*'
        DB      13h
        DB      30h             ; '0'
        DB      13h
        DB      3Eh             ; '>'
        DB      13h
        DB      72h             ; 'r'
        DB      12h

        ; --- START PROC L122A ---
L122A:  LD      A,(L170F)
        LD      B,A
        LD      C,00h
        LD      HL,(L15C6)
L1233:  LD      A,(HL)
        CP      0FFh
        JR      NZ,L1239
        INC     C
L1239:  INC     HL
        INC     HL
        DJNZ    L1233
        RET

L123E:  DB      0CDh
        DB      2Ah             ; '*'
        DB      12h
        DB      3Ah             ; ':'
        DB      15h
        DB      17h
        DB      3Dh             ; '='
        DB      0B9h
        DB      0F2h
        DB      54h             ; 'T'
        DB      12h
        DB      0D1h
        DB      0D1h
        DB      21h             ; '!'
        DB      0EEh
        DB      13h
        DB      0CDh
        DB      36h             ; '6'
        DB      01h
        DB      0C3h
        DB      03h
        DB      01h
        DB      0CDh
        DB      15h
        DB      01h
        DB      0CDh
        DB      45h             ; 'E'
        DB      01h
        DB      36h             ; '6'
        DB      0FFh
        DB      0CDh
        DB      12h
        DB      01h
        DB      0C9h
        DB      0CDh
        DB      15h
        DB      01h
        DB      0CDh
        DB      45h             ; 'E'
        DB      01h
        DB      3Ah             ; ':'
        DB      89h
        DB      17h
        DB      77h             ; 'w'
        DB      0CDh
        DB      12h
        DB      01h
        DB      0C9h
        DB      0CDh
        DB      06h
        DB      01h
        DB      0C9h
        DB      21h             ; '!'
        DB      00h
        DB      00h
        DB      2Bh             ; '+'
        DB      7Ch             ; '|'
        DB      0B5h
        DB      20h             ; ' '
        DB      0FBh
        DB      0C9h
        DB      0CDh
        DB      15h
        DB      01h
        DB      22h             ; '"'
        DB      89h
        DB      17h
        DB      0CDh
        DB      12h
        DB      01h
        DB      0C9h
        DB      0CDh
        DB      15h
        DB      01h
        DB      0CDh
        DB      45h             ; 'E'
        DB      01h
        DB      0E5h
        DB      0CDh
        DB      15h
        DB      01h
        DB      0CDh
        DB      45h             ; 'E'
        DB      01h
        DB      0D1h
        DB      0F5h
        DB      1Ah
        DB      77h             ; 'w'
        DB      0F1h
        DB      12h
        DB      0EDh
        DB      4Bh             ; 'K'
        DB      89h
        DB      17h
        DB      0B9h
        DB      0CCh
        DB      12h
        DB      01h
        DB      7Eh             ; '~'
        DB      0B9h
        DB      0CCh
        DB      12h
        DB      01h
        DB      0C9h
        DB      0CDh
        DB      15h
        DB      01h
        DB      0CDh
        DB      45h             ; 'E'
        DB      01h
        DB      36h             ; '6'
        DB      00h
        DB      0CDh
        DB      12h
        DB      01h
        DB      0C9h
        DB      21h             ; '!'
        DB      64h             ; 'd'
        DB      17h
        DB      36h             ; '6'
        DB      0FFh
        DB      0C9h
        DB      21h             ; '!'
        DB      0Fh
        DB      00h
        DB      18h
        DB      7Ah             ; 'z'
        DB      2Ah             ; '*'
        DB      67h             ; 'g'
        DB      17h
        DB      2Bh             ; '+'
        DB      22h             ; '"'
        DB      67h             ; 'g'
        DB      17h
        DB      0C9h
        DB      2Ah             ; '*'
        DB      67h             ; 'g'
        DB      17h
        DB      0CDh
        DB      48h             ; 'H'
        DB      01h
        DB      0C9h
        DB      0CDh
        DB      15h
        DB      01h
        DB      22h             ; '"'
        DB      67h             ; 'g'
        DB      17h
        DB      0C9h
        DB      3Ah             ; ':'
        DB      89h
        DB      17h
        DB      08h
        DB      3Ah             ; ':'
        DB      8Bh
        DB      17h
        DB      32h             ; '2'
        DB      89h
        DB      17h
        DB      08h
        DB      32h             ; '2'
        DB      8Bh
        DB      17h
        DB      0C9h
        DB      21h             ; '!'
        DB      0Fh
        DB      00h
        DB      18h
        DB      6Ch             ; 'l'
        DB      0CDh
        DB      15h
        DB      01h
        DB      0DDh
        DB      0E5h
        DB      0DDh
        DB      21h             ; '!'
        DB      67h             ; 'g'
        DB      17h
        DB      29h             ; ')'
        DB      11h
        DB      91h
        DB      17h
        DB      19h
        DB      0EDh
        DB      4Bh             ; 'K'
        DB      67h             ; 'g'
        DB      17h
        DB      5Eh             ; '^'
        DB      71h             ; 'q'
        DB      0DDh
        DB      73h             ; 's'
        DB      00h
        DB      23h             ; '#'
        DB      56h             ; 'V'
        DB      70h             ; 'p'
        DB      0DDh
        DB      72h             ; 'r'
        DB      01h
        DB      0DDh
        DB      0E1h
        DB      0C9h
        DB      0CDh
        DB      15h
        DB      01h
        DB      0EDh
        DB      4Bh             ; 'K'
        DB      67h             ; 'g'
        DB      17h
        DB      09h
        DB      22h             ; '"'
        DB      67h             ; 'g'
        DB      17h
        DB      0C9h
        DB      0CDh
        DB      15h
        DB      01h
        DB      0E5h
        DB      0C1h
        DB      2Ah             ; '*'
        DB      67h             ; 'g'
        DB      17h
        DB      37h             ; '7'
        DB      3Fh             ; '?'
        DB      0EDh
        DB      42h             ; 'B'
        DB      22h             ; '"'
        DB      67h             ; 'g'
        DB      17h
        DB      0C9h
        DB      21h             ; '!'
        DB      20h             ; ' '
        DB      17h
        DB      0CDh
        DB      36h             ; '6'
        DB      01h
        DB      0C9h
        DB      21h             ; '!'
        DB      20h             ; ' '
        DB      17h
        DB      0CDh
        DB      36h             ; '6'
        DB      01h
        DB      0CDh
        DB      33h             ; '3'
        DB      01h
        DB      0C9h
        DB      0CDh
        DB      15h
        DB      01h
        DB      01h
        DB      69h             ; 'i'
        DB      17h
        DB      09h
        DB      36h             ; '6'
        DB      0FFh
        DB      0C9h
        DB      0CDh
        DB      15h
        DB      01h
        DB      11h
        DB      8Bh
        DB      17h
        DB      19h
        DB      7Eh             ; '~'
        DB      0F5h
        DB      3Ah             ; ':'
        DB      89h
        DB      17h
        DB      77h             ; 'w'
        DB      0F1h
        DB      32h             ; '2'
        DB      89h
        DB      17h
        DB      0C9h
        DB      0CDh
        DB      15h
        DB      01h
        DB      01h
        DB      69h             ; 'i'
        DB      17h
        DB      09h
        DB      36h             ; '6'
        DB      00h
        DB      0C9h
        DB      21h             ; '!'
        DB      6Eh             ; 'n'
        DB      13h
        DB      0CDh
        DB      36h             ; '6'
        DB      01h
        DB      3Ah             ; ':'
        DB      13h
        DB      17h
        DB      32h             ; '2'
        DB      89h
        DB      17h
        DB      97h
        DB      32h             ; '2'
        DB      78h             ; 'x'
        DB      17h
        DB      0CDh
        DB      12h
        DB      01h
        DB      0C9h
        DB      49h             ; 'I'
        DB      27h             ; '''
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      44h             ; 'D'
        DB      45h             ; 'E'
        DB      41h             ; 'A'
        DB      44h             ; 'D'
        DB      21h             ; '!'
        DB      0Dh
        DB      00h
        DB      0CDh
        DB      15h
        DB      01h
        DB      0CDh
        DB      45h             ; 'E'
        DB      01h
        DB      0E5h
        DB      0CDh
        DB      15h
        DB      01h
        DB      0D1h
        DB      1Ah
        DB      47h             ; 'G'
        DB      7Dh             ; '}'
        DB      21h             ; '!'
        DB      89h
        DB      17h
        DB      12h
        DB      0BEh
        DB      0CCh
        DB      12h
        DB      01h
        DB      78h             ; 'x'
        DB      0BEh
        DB      0CCh
        DB      12h
        DB      01h
        DB      0C9h
        DB      21h             ; '!'
        DB      0B4h
        DB      13h
        DB      0CDh
        DB      36h             ; '6'
        DB      01h
        DB      0CDh
        DB      39h             ; '9'
        DB      01h
        DB      3Ah             ; ':'
        DB      0D3h
        DB      15h
        DB      0FEh
        DB      4Eh             ; 'N'
        DB      0CAh
        DB      00h
        DB      0E0h
        DB      0FEh
        DB      59h             ; 'Y'
        DB      20h             ; ' '
        DB      0EBh
        DB      0E1h
        DB      0E1h
        DB      0E1h
        DB      0C3h
        DB      2Dh             ; '-'
        DB      01h
        DB      0CDh
        DB      12h
        DB      01h
        DB      0C9h
        DB      54h             ; 'T'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      64h             ; 'd'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      75h             ; 'u'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      57h             ; 'W'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      72h             ; 'r'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      64h             ; 'd'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      75h             ; 'u'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      67h             ; 'g'
        DB      61h             ; 'a'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      3Fh             ; '?'
        DB      20h             ; ' '
        DB      00h
        DB      49h             ; 'I'
        DB      27h             ; '''
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      72h             ; 'r'
        DB      79h             ; 'y'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      75h             ; 'u'
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      54h             ; 'T'
        DB      72h             ; 'r'
        DB      79h             ; 'y'
        DB      3Ah             ; ':'
        DB      20h             ; ' '
        DB      54h             ; 'T'
        DB      41h             ; 'A'
        DB      4Bh             ; 'K'
        DB      45h             ; 'E'
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      4Eh             ; 'N'
        DB      56h             ; 'V'
        DB      45h             ; 'E'
        DB      4Eh             ; 'N'
        DB      54h             ; 'T'
        DB      4Fh             ; 'O'
        DB      52h             ; 'R'
        DB      59h             ; 'Y'
        DB      0Dh
        DB      00h
        DB      0Eh
        DB      00h
        DB      0DDh
        DB      0E5h
        DB      3Ah             ; ':'
        DB      0Fh
        DB      17h
        DB      47h             ; 'G'
        DB      04h
        DB      0DDh
        DB      2Ah             ; '*'
        DB      0C6h
        DB      15h
        DB      2Ah             ; '*'
        DB      0C8h
        DB      15h
        DB      5Eh             ; '^'
        DB      23h             ; '#'
        DB      56h             ; 'V'
        DB      23h             ; '#'
        DB      13h
        DB      1Ah
        DB      0FEh
        DB      2Ah             ; '*'
        DB      20h             ; ' '
        DB      09h
        DB      3Ah             ; ':'
        DB      1Eh
        DB      17h
        DB      0DDh
        DB      0BEh
        DB      00h
        DB      20h             ; ' '
        DB      01h
        DB      0Ch
        DB      0DDh
        DB      23h             ; '#'
        DB      0DDh
        DB      23h             ; '#'
        DB      10h
        DB      0E7h
        DB      0DDh
        DB      0E1h
        DB      21h             ; '!'
        DB      7Bh             ; '{'
        DB      14h
        DB      0CDh
        DB      36h             ; '6'
        DB      01h
        DB      69h             ; 'i'
        DB      26h             ; '&'
        DB      00h
        DB      0CDh
        DB      48h             ; 'H'
        DB      01h
        DB      21h             ; '!'
        DB      85h
        DB      14h
        DB      0CDh
        DB      36h             ; '6'
        DB      01h
        DB      59h             ; 'Y'
        DB      16h
        DB      00h
        DB      21h             ; '!'
        DB      64h             ; 'd'
        DB      00h
        DB      0CDh
        DB      0Eh
        DB      15h
        DB      0EBh
        DB      2Ah             ; '*'
        DB      19h
        DB      17h
        DB      0CDh
        DB      29h             ; ')'
        DB      15h
        DB      0CDh
        DB      48h             ; 'H'
        DB      01h
        DB      0CDh
        DB      33h             ; '3'
        DB      01h
        DB      3Ah             ; ':'
        DB      19h
        DB      17h
        DB      0B9h
        DB      0C0h
        DB      21h             ; '!'
        DB      0B5h
        DB      14h
        DB      0CDh
        DB      36h             ; '6'
        DB      01h
        DB      0C3h
        DB      95h
        DB      13h
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      00h
        DB      54h             ; 'T'
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      41h             ; 'A'
        DB      53h             ; 'S'
        DB      55h             ; 'U'
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      53h             ; 'S'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      4Fh             ; 'O'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      63h             ; 'c'
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      31h             ; '1'
        DB      30h             ; '0'
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      72h             ; 'r'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      3Ah             ; ':'
        DB      20h             ; ' '
        DB      00h
        DB      46h             ; 'F'
        DB      41h             ; 'A'
        DB      4Eh             ; 'N'
        DB      54h             ; 'T'
        DB      41h             ; 'A'
        DB      53h             ; 'S'
        DB      54h             ; 'T'
        DB      49h             ; 'I'
        DB      43h             ; 'C'
        DB      21h             ; '!'
        DB      20h             ; ' '
        DB      59h             ; 'Y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      27h             ; '''
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Fh             ; 'o'
        DB      6Ch             ; 'l'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      4Ch             ; 'L'
        DB      4Ch             ; 'L'
        DB      21h             ; '!'
        DB      0Dh
        DB      00h
        DB      0CDh
        DB      0Ch
        DB      01h
        DB      0C9h
        DB      21h             ; '!'
        DB      00h
        DB      00h
        DB      0C3h
        DB      37h             ; '7'
        DB      13h
        DB      21h             ; '!'
        DB      00h
        DB      00h
        DB      0C3h
        DB      53h             ; 'S'
        DB      13h
        DB      2Ah             ; '*'
        DB      1Bh
        DB      17h
        DB      22h             ; '"'
        DB      0A1h
        DB      17h
        DB      2Ah             ; '*'
        DB      0C6h
        DB      15h
        DB      01h
        DB      12h
        DB      00h
        DB      09h
        DB      36h             ; '6'
        DB      0FFh
        DB      97h
        DB      32h             ; '2'
        DB      79h             ; 'y'
        DB      17h
        DB      0CDh
        DB      12h
        DB      01h
        DB      0C9h
        DB      0CDh
        DB      15h
        DB      01h
        DB      0CDh
        DB      45h             ; 'E'
        DB      01h
        DB      0E5h
        DB      0CDh
        DB      15h
        DB      01h
        DB      0CDh
        DB      45h             ; 'E'
        DB      01h
        DB      0E1h
        DB      77h             ; 'w'
        DB      0C9h
        DB      0F5h
        DB      0D5h
        DB      0C5h
        DB      06h
        DB      10h
        DB      4Ah             ; 'J'
        DB      7Bh             ; '{'
        DB      0EBh
        DB      21h             ; '!'
        DB      00h
        DB      00h
        DB      0CBh
        DB      39h             ; '9'
        DB      0CBh
        DB      1Fh
        DB      30h             ; '0'
        DB      01h
        DB      19h
        DB      0EBh
        DB      29h             ; ')'
        DB      0EBh
        DB      10h
        DB      0F4h
        DB      0C1h
        DB      0D1h
        DB      0F1h
        DB      0C9h

        ; --- START PROC L1529 ---
L1529:  PUSH    IX
        PUSH    IY
        PUSH    BC
        PUSH    AF
        LD      A,10h
        LD      IX,0000h
        LD      (L1739),IX
        LD      (L173B),IX
        LD      IX,1739h
        LD      IY,173Bh
L1545:  SLA     (IX+00h)
        RL      (IX+01h)
        SLA     E
        RL      D
        RL      (IY+00h)
        RL      (IY+01h)
        PUSH    HL
        SCF
        CCF
        LD      BC,(L173B)
        SBC     HL,BC
        JR      Z,L1567
        JP      P,L1580
L1567:  LD      BC,(L1739)
        INC     BC
        LD      (L1739),BC
        SCF
        CCF
        PUSH    DE
        LD      DE,0000h
        EX      DE,HL
        SBC     HL,DE
        POP     DE
        LD      (IY+00h),L
        LD      (IY+01h),H
L1580:  POP     HL
        DEC     A
        JR      NZ,L1545
        LD      HL,(L1739)
        LD      DE,(L173B)
        POP     AF
        POP     BC
        POP     IY
        POP     IX
        RET

L1592:  DB      00h
        DB      4Eh             ; 'N'
        DB      5Ah             ; 'Z'
        DB      2Ch             ; ','
        DB      50h             ; 'P'
        DB      55h             ; 'U'
        DB      54h             ; 'T'
        DB      5Ah             ; 'Z'
        DB      40h             ; '@'
        DB      0Bh
        DB      08h
        DB      09h
        DB      50h             ; 'P'
        DB      55h             ; 'U'
L15A0:  DB      0A5h
        DB      30h             ; '0'
L15A2:  DB      4Fh             ; 'O'
        DB      31h             ; '1'
        DB      0F9h
        DB      31h             ; '1'
        DB      0A3h
        DB      32h             ; '2'
        DB      4Dh             ; 'M'
        DB      33h             ; '3'
        DB      0F7h
        DB      33h             ; '3'
        DB      0A1h
        DB      34h             ; '4'
        DB      0F5h
        DB      35h             ; '5'
        DB      49h             ; 'I'
        DB      37h             ; '7'
        DB      9Dh
        DB      38h             ; '8'
        DB      0F1h
        DB      39h             ; '9'
L15B6:  DB      45h             ; 'E'
        DB      3Bh             ; ';'
        DB      89h
        DB      3Bh             ; ';'
        DB      0CDh
        DB      3Bh             ; ';'
        DB      11h
        DB      3Ch             ; '<'
        DB      55h             ; 'U'
        DB      3Ch             ; '<'
        DB      99h
        DB      3Ch             ; '<'
        DB      0DDh
        DB      3Ch             ; '<'
L15C4:  DB      21h             ; '!'
        DB      3Dh             ; '='
L15C6:  DB      19h
        DB      2Fh             ; '/'
L15C8:  DB      9Dh
        DB      2Fh             ; '/'
L15CA:  DB      21h             ; '!'
        DB      30h             ; '0'
        DB      18h
        DB      2Fh             ; '/'
L15CE:  DB      0D8h
        DB      17h
L15D0:  DB      0F0h
        DB      18h
L15D2:  DB      01h
L15D3:  DB      4Eh             ; 'N'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      39h             ; '9'
        DB      35h             ; '5'
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      34h             ; '4'
        DB      30h             ; '0'
        DB      35h             ; '5'
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      34h             ; '4'
        DB      30h             ; '0'
        DB      34h             ; '4'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      31h             ; '1'
        DB      37h             ; '7'
        DB      37h             ; '7'
        DB      30h             ; '0'
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      39h             ; '9'
        DB      30h             ; '0'
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      39h             ; '9'
        DB      34h             ; '4'
        DB      35h             ; '5'
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      34h             ; '4'
        DB      32h             ; '2'
        DB      31h             ; '1'
        DB      32h             ; '2'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      38h             ; '8'
        DB      32h             ; '2'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      31h             ; '1'
        DB      30h             ; '0'
        DB      36h             ; '6'
        DB      31h             ; '1'
        DB      31h             ; '1'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      31h             ; '1'
        DB      30h             ; '0'
        DB      39h             ; '9'
        DB      35h             ; '5'
        DB      39h             ; '9'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      34h             ; '4'
        DB      34h             ; '4'
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      31h             ; '1'
        DB      36h             ; '6'
        DB      31h             ; '1'
        DB      33h             ; '3'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      38h             ; '8'
        DB      32h             ; '2'
        DB      31h             ; '1'
        DB      32h             ; '2'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      32h             ; '2'
        DB      37h             ; '7'
        DB      33h             ; '3'
        DB      37h             ; '7'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      34h             ; '4'
        DB      30h             ; '0'
        DB      34h             ; '4'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      31h             ; '1'
        DB      34h             ; '4'
        DB      38h             ; '8'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      32h             ; '2'
        DB      36h             ; '6'
        DB      35h             ; '5'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      31h             ; '1'
        DB      36h             ; '6'
        DB      35h             ; '5'
        DB      30h             ; '0'
        DB      30h             ; '0'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      32h             ; '2'
        DB      37h             ; '7'
        DB      33h             ; '3'
        DB      37h             ; '7'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      34h             ; '4'
        DB      30h             ; '0'
        DB      34h             ; '4'
        DB      20h             ; ' '
        DB      0Dh
        DB      20h             ; ' '
        DB      53h             ; 'S'
        DB      2Fh             ; '/'
        DB      53h             ; 'S'
        DB      31h             ; '1'
        DB      0Dh
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
L16F3:  DB      0A0h
        DB      01h
        DB      0B9h
        DB      3Dh             ; '='
L16F7:  DB      01h
        DB      00h
L16F9:  DB      80h
        DB      3Dh             ; '='
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
L1707:  DB      00h
        DB      00h
L1709:  DB      03h
        DB      00h
L170B:  DB      45h             ; 'E'
        DB      00h
L170D:  DB      0A9h
        DB      00h
L170F:  DB      41h             ; 'A'
        DB      00h
        DB      4Bh             ; 'K'
        DB      00h
L1713:  DB      21h             ; '!'
        DB      00h
L1715:  DB      06h
        DB      00h
L1717:  DB      0Bh
        DB      00h
        DB      0Dh
        DB      00h
L171B:  DB      7Dh             ; '}'
        DB      00h
L171D:  DB      00h
        DB      03h
        DB      00h
L1720:  DB      00h
L1721:  DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
L1739:  DB      00h
        DB      00h
L173B:  DB      00h
        DB      00h
        DB      59h             ; 'Y'
        DB      0B0h
        DB      9Dh
        DB      0B0h
        DB      0E1h
        DB      0B0h
        DB      25h             ; '%'
        DB      0B1h
        DB      69h             ; 'i'
        DB      0B1h
        DB      0ADh
        DB      0B1h
        DB      71h             ; 'q'
        DB      0A9h
        DB      0C5h
        DB      0AAh
        DB      19h
        DB      0ACh
        DB      6Dh             ; 'm'
        DB      0ADh
        DB      0C1h
        DB      0AEh
L1753:  DB      0C0h
        DB      3Fh             ; '?'
        DB      06h
L1756:  DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      30h             ; '0'
L175C:  DB      1Ah
        DB      00h
L175E:  DB      00h
        DB      00h
L1760:  DB      00h
        DB      00h
L1762:  DB      0FFh
L1763:  DB      0FFh
L1764:  DB      00h
L1765:  DB      00h
L1766:  DB      1Ah
        DB      41h             ; 'A'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0FFh
        DB      00h
L1778:  DB      00h
L1779:  DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
L1789:  DB      0Bh
        DB      00h
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FEh
        DB      03h
        DB      00h
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0DFh
        DB      00h
        DB      00h
        DB      0BFh
        DB      9Fh
        DB      94h
        DB      2Fh             ; '/'
        DB      0FDh
        DB      0BDh
        DB      9Fh
        DB      0FDh
L17A1:  DB      7Dh             ; '}'
        DB      00h
L17A3:  DB      61h             ; 'a'
        DB      06h
        DB      0FFh
        DB      0EFh
        DB      3Ch             ; '<'
        DB      0EFh
        DB      2Dh             ; '-'
        DB      2Fh             ; '/'
        DB      2Fh             ; '/'
        DB      6Fh             ; 'o'
        DB      0ADh
        DB      0EFh
        DB      29h             ; ')'
        DB      0D0h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      80h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      80h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      41h             ; 'A'
        DB      4Eh             ; 'N'
        DB      59h             ; 'Y'
        DB      00h
        DB      4Eh             ; 'N'
        DB      4Fh             ; 'O'
        DB      52h             ; 'R'
        DB      00h
        DB      53h             ; 'S'
        DB      4Fh             ; 'O'
        DB      55h             ; 'U'
        DB      00h
        DB      45h             ; 'E'
        DB      41h             ; 'A'
        DB      53h             ; 'S'
        DB      00h
        DB      57h             ; 'W'
        DB      45h             ; 'E'
        DB      53h             ; 'S'
        DB      00h
        DB      55h             ; 'U'
        DB      50h             ; 'P'
        DB      00h
        DB      00h
        DB      44h             ; 'D'
        DB      4Fh             ; 'O'
        DB      57h             ; 'W'
        DB      00h
        DB      4Eh             ; 'N'
        DB      45h             ; 'E'
        DB      54h             ; 'T'
        DB      00h
        DB      46h             ; 'F'
        DB      49h             ; 'I'
        DB      53h             ; 'S'
        DB      00h
        DB      41h             ; 'A'
        DB      57h             ; 'W'
        DB      41h             ; 'A'
        DB      00h
        DB      4Dh             ; 'M'
        DB      49h             ; 'I'
        DB      52h             ; 'R'
        DB      00h
        DB      41h             ; 'A'
        DB      58h             ; 'X'
        DB      45h             ; 'E'
        DB      2Ah             ; '*'
        DB      41h             ; 'A'
        DB      58h             ; 'X'
        DB      00h
        DB      00h
        DB      57h             ; 'W'
        DB      41h             ; 'A'
        DB      54h             ; 'T'
        DB      00h
        DB      42h             ; 'B'
        DB      4Fh             ; 'O'
        DB      54h             ; 'T'
        DB      2Ah             ; '*'
        DB      43h             ; 'C'
        DB      4Fh             ; 'O'
        DB      4Eh             ; 'N'
        DB      00h
        DB      48h             ; 'H'
        DB      4Fh             ; 'O'
        DB      4Ch             ; 'L'
        DB      00h
        DB      4Ch             ; 'L'
        DB      41h             ; 'A'
        DB      4Dh             ; 'M'
        DB      00h
        DB      53h             ; 'S'
        DB      50h             ; 'P'
        DB      49h             ; 'I'
        DB      00h
        DB      57h             ; 'W'
        DB      49h             ; 'I'
        DB      4Eh             ; 'N'
        DB      00h
        DB      44h             ; 'D'
        DB      4Fh             ; 'O'
        DB      4Fh             ; 'O'
        DB      00h
        DB      4Dh             ; 'M'
        DB      55h             ; 'U'
        DB      44h             ; 'D'
        DB      2Ah             ; '*'
        DB      4Dh             ; 'M'
        DB      45h             ; 'E'
        DB      44h             ; 'D'
        DB      00h
        DB      42h             ; 'B'
        DB      45h             ; 'E'
        DB      45h             ; 'E'
        DB      00h
        DB      52h             ; 'R'
        DB      4Fh             ; 'O'
        DB      43h             ; 'C'
        DB      00h
        DB      47h             ; 'G'
        DB      41h             ; 'A'
        DB      53h             ; 'S'
        DB      00h
        DB      46h             ; 'F'
        DB      4Ch             ; 'L'
        DB      49h             ; 'I'
        DB      00h
        DB      45h             ; 'E'
        DB      47h             ; 'G'
        DB      47h             ; 'G'
        DB      00h
        DB      4Fh             ; 'O'
        DB      49h             ; 'I'
        DB      4Ch             ; 'L'
        DB      2Ah             ; '*'
        DB      53h             ; 'S'
        DB      4Ch             ; 'L'
        DB      49h             ; 'I'
        DB      00h
        DB      4Bh             ; 'K'
        DB      45h             ; 'E'
        DB      59h             ; 'Y'
        DB      00h
        DB      48h             ; 'H'
        DB      45h             ; 'E'
        DB      4Ch             ; 'L'
        DB      00h
        DB      42h             ; 'B'
        DB      55h             ; 'U'
        DB      4Eh             ; 'N'
        DB      00h
        DB      49h             ; 'I'
        DB      4Eh             ; 'N'
        DB      56h             ; 'V'
        DB      00h
        DB      4Ch             ; 'L'
        DB      45h             ; 'E'
        DB      44h             ; 'D'
        DB      00h
        DB      54h             ; 'T'
        DB      48h             ; 'H'
        DB      52h             ; 'R'
        DB      00h
        DB      43h             ; 'C'
        DB      52h             ; 'R'
        DB      4Fh             ; 'O'
        DB      00h
        DB      42h             ; 'B'
        DB      52h             ; 'R'
        DB      49h             ; 'I'
        DB      00h
        DB      42h             ; 'B'
        DB      45h             ; 'E'
        DB      41h             ; 'A'
        DB      00h
        DB      44h             ; 'D'
        DB      52h             ; 'R'
        DB      41h             ; 'A'
        DB      00h
        DB      52h             ; 'R'
        DB      55h             ; 'U'
        DB      47h             ; 'G'
        DB      00h
        DB      52h             ; 'R'
        DB      55h             ; 'U'
        DB      42h             ; 'B'
        DB      00h
        DB      48h             ; 'H'
        DB      4Fh             ; 'O'
        DB      4Eh             ; 'N'
        DB      00h
        DB      46h             ; 'F'
        DB      52h             ; 'R'
        DB      55h             ; 'U'
        DB      00h
        DB      4Fh             ; 'O'
        DB      58h             ; 'X'
        DB      00h
        DB      00h
        DB      52h             ; 'R'
        DB      49h             ; 'I'
        DB      4Eh             ; 'N'
        DB      00h
        DB      4Ch             ; 'L'
        DB      45h             ; 'E'
        DB      45h             ; 'E'
        DB      2Ah             ; '*'
        DB      42h             ; 'B'
        DB      49h             ; 'I'
        DB      54h             ; 'T'
        DB      00h
        DB      42h             ; 'B'
        DB      52h             ; 'R'
        DB      41h             ; 'A'
        DB      00h
        DB      53h             ; 'S'
        DB      49h             ; 'I'
        DB      47h             ; 'G'
        DB      00h
        DB      42h             ; 'B'
        DB      4Ch             ; 'L'
        DB      41h             ; 'A'
        DB      00h
        DB      57h             ; 'W'
        DB      45h             ; 'E'
        DB      42h             ; 'B'
        DB      2Ah             ; '*'
        DB      57h             ; 'W'
        DB      52h             ; 'R'
        DB      49h             ; 'I'
        DB      00h
        DB      53h             ; 'S'
        DB      57h             ; 'W'
        DB      41h             ; 'A'
        DB      00h
        DB      4Ch             ; 'L'
        DB      41h             ; 'A'
        DB      56h             ; 'V'
        DB      2Ah             ; '*'
        DB      44h             ; 'D'
        DB      41h             ; 'A'
        DB      4Dh             ; 'M'
        DB      00h
        DB      48h             ; 'H'
        DB      41h             ; 'A'
        DB      4Ch             ; 'L'
        DB      00h
        DB      54h             ; 'T'
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      2Ah             ; '*'
        DB      53h             ; 'S'
        DB      54h             ; 'T'
        DB      55h             ; 'U'
        DB      00h
        DB      46h             ; 'F'
        DB      49h             ; 'I'
        DB      52h             ; 'R'
        DB      00h
        DB      53h             ; 'S'
        DB      48h             ; 'H'
        DB      4Fh             ; 'O'
        DB      2Ah             ; '*'
        DB      42h             ; 'B'
        DB      41h             ; 'A'
        DB      4Eh             ; 'N'
        DB      00h
        DB      48h             ; 'H'
        DB      41h             ; 'A'
        DB      4Eh             ; 'N'
        DB      00h
        DB      47h             ; 'G'
        DB      4Ch             ; 'L'
        DB      41h             ; 'A'
        DB      00h
        DB      41h             ; 'A'
        DB      52h             ; 'R'
        DB      4Fh             ; 'O'
        DB      00h
        DB      47h             ; 'G'
        DB      41h             ; 'A'
        DB      4Dh             ; 'M'
        DB      00h
        DB      42h             ; 'B'
        DB      4Fh             ; 'O'
        DB      4Fh             ; 'O'
        DB      00h
        DB      43h             ; 'C'
        DB      48h             ; 'H'
        DB      41h             ; 'A'
        DB      00h
        DB      4Ch             ; 'L'
        DB      41h             ; 'A'
        DB      4Bh             ; 'K'
        DB      00h
        DB      59h             ; 'Y'
        DB      4Fh             ; 'O'
        DB      48h             ; 'H'
        DB      00h
        DB      41h             ; 'A'
        DB      55h             ; 'U'
        DB      54h             ; 'T'
        DB      00h
        DB      47h             ; 'G'
        DB      4Fh             ; 'O'
        DB      00h
        DB      2Ah             ; '*'
        DB      45h             ; 'E'
        DB      4Eh             ; 'N'
        DB      54h             ; 'T'
        DB      2Ah             ; '*'
        DB      52h             ; 'R'
        DB      55h             ; 'U'
        DB      4Eh             ; 'N'
        DB      2Ah             ; '*'
        DB      57h             ; 'W'
        DB      41h             ; 'A'
        DB      4Ch             ; 'L'
        DB      2Ah             ; '*'
        DB      43h             ; 'C'
        DB      4Ch             ; 'L'
        DB      49h             ; 'I'
        DB      00h
        DB      4Ah             ; 'J'
        DB      55h             ; 'U'
        DB      4Dh             ; 'M'
        DB      00h
        DB      41h             ; 'A'
        DB      54h             ; 'T'
        DB      00h
        DB      00h
        DB      43h             ; 'C'
        DB      48h             ; 'H'
        DB      4Fh             ; 'O'
        DB      2Ah             ; '*'
        DB      43h             ; 'C'
        DB      55h             ; 'U'
        DB      54h             ; 'T'
        DB      00h
        DB      47h             ; 'G'
        DB      45h             ; 'E'
        DB      54h             ; 'T'
        DB      2Ah             ; '*'
        DB      54h             ; 'T'
        DB      41h             ; 'A'
        DB      4Bh             ; 'K'
        DB      2Ah             ; '*'
        DB      50h             ; 'P'
        DB      49h             ; 'I'
        DB      43h             ; 'C'
        DB      2Ah             ; '*'
        DB      43h             ; 'C'
        DB      41h             ; 'A'
        DB      54h             ; 'T'
        DB      00h
        DB      4Ch             ; 'L'
        DB      49h             ; 'I'
        DB      47h             ; 'G'
        DB      2Ah             ; '*'
        DB      2Eh             ; '.'
        DB      00h
        DB      00h
        DB      2Ah             ; '*'
        DB      49h             ; 'I'
        DB      47h             ; 'G'
        DB      4Eh             ; 'N'
        DB      2Ah             ; '*'
        DB      42h             ; 'B'
        DB      55h             ; 'U'
        DB      52h             ; 'R'
        DB      00h
        DB      44h             ; 'D'
        DB      52h             ; 'R'
        DB      4Fh             ; 'O'
        DB      2Ah             ; '*'
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      4Ch             ; 'L'
        DB      2Ah             ; '*'
        DB      53h             ; 'S'
        DB      50h             ; 'P'
        DB      49h             ; 'I'
        DB      2Ah             ; '*'
        DB      4Ch             ; 'L'
        DB      45h             ; 'E'
        DB      41h             ; 'A'
        DB      2Ah             ; '*'
        DB      47h             ; 'G'
        DB      49h             ; 'I'
        DB      56h             ; 'V'
        DB      2Ah             ; '*'
        DB      50h             ; 'P'
        DB      4Fh             ; 'O'
        DB      55h             ; 'U'
        DB      00h
        DB      54h             ; 'T'
        DB      48h             ; 'H'
        DB      52h             ; 'R'
        DB      2Ah             ; '*'
        DB      54h             ; 'T'
        DB      4Fh             ; 'O'
        DB      53h             ; 'S'
        DB      00h
        DB      51h             ; 'Q'
        DB      55h             ; 'U'
        DB      49h             ; 'I'
        DB      00h
        DB      53h             ; 'S'
        DB      57h             ; 'W'
        DB      49h             ; 'I'
        DB      00h
        DB      52h             ; 'R'
        DB      55h             ; 'U'
        DB      42h             ; 'B'
        DB      00h
        DB      4Ch             ; 'L'
        DB      4Fh             ; 'O'
        DB      4Fh             ; 'O'
        DB      2Ah             ; '*'
        DB      45h             ; 'E'
        DB      58h             ; 'X'
        DB      41h             ; 'A'
        DB      2Ah             ; '*'
        DB      44h             ; 'D'
        DB      45h             ; 'E'
        DB      53h             ; 'S'
        DB      00h
        DB      53h             ; 'S'
        DB      54h             ; 'T'
        DB      4Fh             ; 'O'
        DB      00h
        DB      53h             ; 'S'
        DB      43h             ; 'C'
        DB      4Fh             ; 'O'
        DB      00h
        DB      49h             ; 'I'
        DB      4Eh             ; 'N'
        DB      56h             ; 'V'
        DB      00h
        DB      53h             ; 'S'
        DB      41h             ; 'A'
        DB      56h             ; 'V'
        DB      00h
        DB      57h             ; 'W'
        DB      41h             ; 'A'
        DB      4Bh             ; 'K'
        DB      00h
        DB      55h             ; 'U'
        DB      4Eh             ; 'N'
        DB      4Ch             ; 'L'
        DB      00h
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      41h             ; 'A'
        DB      00h
        DB      41h             ; 'A'
        DB      54h             ; 'T'
        DB      54h             ; 'T'
        DB      2Ah             ; '*'
        DB      53h             ; 'S'
        DB      4Ch             ; 'L'
        DB      41h             ; 'A'
        DB      2Ah             ; '*'
        DB      4Bh             ; 'K'
        DB      49h             ; 'I'
        DB      4Ch             ; 'L'
        DB      00h
        DB      44h             ; 'D'
        DB      52h             ; 'R'
        DB      49h             ; 'I'
        DB      2Ah             ; '*'
        DB      45h             ; 'E'
        DB      41h             ; 'A'
        DB      54h             ; 'T'
        DB      00h
        DB      2Eh             ; '.'
        DB      00h
        DB      00h
        DB      00h
        DB      46h             ; 'F'
        DB      49h             ; 'I'
        DB      4Eh             ; 'N'
        DB      2Ah             ; '*'
        DB      4Ch             ; 'L'
        DB      4Fh             ; 'O'
        DB      43h             ; 'C'
        DB      00h
        DB      48h             ; 'H'
        DB      45h             ; 'E'
        DB      4Ch             ; 'L'
        DB      00h
        DB      53h             ; 'S'
        DB      41h             ; 'A'
        DB      59h             ; 'Y'
        DB      2Ah             ; '*'
        DB      53h             ; 'S'
        DB      50h             ; 'P'
        DB      45h             ; 'E'
        DB      2Ah             ; '*'
        DB      43h             ; 'C'
        DB      41h             ; 'A'
        DB      4Ch             ; 'L'
        DB      00h
        DB      53h             ; 'S'
        DB      43h             ; 'C'
        DB      52h             ; 'R'
        DB      2Ah             ; '*'
        DB      59h             ; 'Y'
        DB      45h             ; 'E'
        DB      4Ch             ; 'L'
        DB      2Ah             ; '*'
        DB      48h             ; 'H'
        DB      4Fh             ; 'O'
        DB      4Ch             ; 'L'
        DB      00h
        DB      2Eh             ; '.'
        DB      00h
        DB      00h
        DB      00h
        DB      46h             ; 'F'
        DB      49h             ; 'I'
        DB      4Ch             ; 'L'
        DB      00h
        DB      43h             ; 'C'
        DB      52h             ; 'R'
        DB      4Fh             ; 'O'
        DB      00h
        DB      44h             ; 'D'
        DB      41h             ; 'A'
        DB      4Dh             ; 'M'
        DB      00h
        DB      4Dh             ; 'M'
        DB      41h             ; 'A'
        DB      4Bh             ; 'K'
        DB      2Ah             ; '*'
        DB      42h             ; 'B'
        DB      55h             ; 'U'
        DB      49h             ; 'I'
        DB      00h
        DB      57h             ; 'W'
        DB      41h             ; 'A'
        DB      56h             ; 'V'
        DB      2Ah             ; '*'
        DB      54h             ; 'T'
        DB      49h             ; 'I'
        DB      43h             ; 'C'
        DB      2Ah             ; '*'
        DB      4Bh             ; 'K'
        DB      49h             ; 'I'
        DB      43h             ; 'C'
        DB      2Ah             ; '*'
        DB      4Bh             ; 'K'
        DB      49h             ; 'I'
        DB      53h             ; 'S'
        DB      2Ah             ; '*'
        DB      54h             ; 'T'
        DB      4Fh             ; 'O'
        DB      55h             ; 'U'
        DB      2Ah             ; '*'
        DB      46h             ; 'F'
        DB      45h             ; 'E'
        DB      45h             ; 'E'
        DB      2Ah             ; '*'
        DB      46h             ; 'F'
        DB      55h             ; 'U'
        DB      43h             ; 'C'
        DB      2Ah             ; '*'
        DB      48h             ; 'H'
        DB      49h             ; 'I'
        DB      54h             ; 'T'
        DB      2Ah             ; '*'
        DB      50h             ; 'P'
        DB      4Fh             ; 'O'
        DB      4Bh             ; 'K'
        DB      00h
        DB      4Fh             ; 'O'
        DB      50h             ; 'P'
        DB      45h             ; 'E'
        DB      00h
        DB      0Ch
        DB      64h             ; 'd'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      77h             ; 'w'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      70h             ; 'p'
        DB      1Ah
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      70h             ; 'p'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      79h             ; 'y'
        DB      70h             ; 'p'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      1Eh
        DB      64h             ; 'd'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      70h             ; 'p'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      75h             ; 'u'
        DB      6Dh             ; 'm'
        DB      70h             ; 'p'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      77h             ; 'w'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      70h             ; 'p'
        DB      1Ch
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      75h             ; 'u'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      75h             ; 'u'
        DB      6Dh             ; 'm'
        DB      70h             ; 'p'
        DB      22h             ; '"'
        DB      73h             ; 's'
        DB      65h             ; 'e'
        DB      6Dh             ; 'm'
        DB      69h             ; 'i'
        DB      2Dh             ; '-'
        DB      64h             ; 'd'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      6Bh             ; 'k'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      16h
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      70h             ; 'p'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      0Ch
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      61h             ; 'a'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      6Eh             ; 'n'
        DB      12h
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      38h             ; '8'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      69h             ; 'i'
        DB      64h             ; 'd'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      0Eh
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      79h             ; 'y'
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      1Bh
        DB      2Ah             ; '*'
        DB      49h             ; 'I'
        DB      27h             ; '''
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      06h
        DB      66h             ; 'f'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      0Ch
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      7Ah             ; 'z'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      70h             ; 'p'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      0Ch
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      7Ah             ; 'z'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      70h             ; 'p'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      0Ch
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      7Ah             ; 'z'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      70h             ; 'p'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      0Ch
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      7Ah             ; 'z'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      70h             ; 'p'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      0Ch
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      7Ah             ; 'z'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      70h             ; 'p'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      0Ch
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      7Ah             ; 'z'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      70h             ; 'p'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      95h
        DB      2Ah             ; '*'
        DB      49h             ; 'I'
        DB      27h             ; '''
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      70h             ; 'p'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      6Dh             ; 'm'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      48h             ; 'H'
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      68h             ; 'h'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      62h             ; 'b'
        DB      6Fh             ; 'o'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      0Ah
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      70h             ; 'p'
        DB      61h             ; 'a'
        DB      69h             ; 'i'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      4Fh             ; 'O'
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      72h             ; 'r'
        DB      69h             ; 'i'
        DB      63h             ; 'c'
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      75h             ; 'u'
        DB      70h             ; 'p'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      63h             ; 'c'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      73h             ; 's'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      61h             ; 'a'
        DB      63h             ; 'c'
        DB      65h             ; 'e'
        DB      0Ah
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      61h             ; 'a'
        DB      63h             ; 'c'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      54h             ; 'T'
        DB      68h             ; 'h'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      2Dh             ; '-'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      46h             ; 'F'
        DB      2Ah             ; '*'
        DB      49h             ; 'I'
        DB      27h             ; '''
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      6Eh             ; 'n'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      6Dh             ; 'm'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      63h             ; 'c'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      73h             ; 's'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      0Ah
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      54h             ; 'T'
        DB      68h             ; 'h'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      2Dh             ; '-'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      0Dh
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      79h             ; 'y'
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      49h             ; 'I'
        DB      2Ah             ; '*'
        DB      49h             ; 'I'
        DB      27h             ; '''
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      6Eh             ; 'n'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      54h             ; 'T'
        DB      68h             ; 'h'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      2Dh             ; '-'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      0Ah
        DB      41h             ; 'A'
        DB      63h             ; 'c'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      73h             ; 's'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      0Bh
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      0Ch
        DB      73h             ; 's'
        DB      75h             ; 'u'
        DB      6Eh             ; 'n'
        DB      6Eh             ; 'n'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      66h             ; 'f'
        DB      2Ah             ; '*'
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      6Bh             ; 'k'
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      27h             ; '''
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      62h             ; 'b'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Eh             ; 'n'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      54h             ; 'T'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      27h             ; '''
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      0Ah
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      70h             ; 'p'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      66h             ; 'f'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      6Bh             ; 'k'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      70h             ; 'p'
        DB      6Fh             ; 'o'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      61h             ; 'a'
        DB      69h             ; 'i'
        DB      6Ch             ; 'l'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      4Fh             ; 'O'
        DB      68h             ; 'h'
        DB      20h             ; ' '
        DB      48h             ; 'H'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      21h             ; '!'
        DB      0Ch
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      64h             ; 'd'
        DB      64h             ; 'd'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      0Eh
        DB      71h             ; 'q'
        DB      75h             ; 'u'
        DB      69h             ; 'i'
        DB      63h             ; 'c'
        DB      6Bh             ; 'k'
        DB      2Dh             ; '-'
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      6Fh             ; 'o'
        DB      67h             ; 'g'
        DB      2Fh             ; '/'
        DB      4Dh             ; 'M'
        DB      65h             ; 'e'
        DB      6Dh             ; 'm'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      70h             ; 'p'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      43h             ; 'C'
        DB      4Fh             ; 'O'
        DB      4Dh             ; 'M'
        DB      50h             ; 'P'
        DB      55h             ; 'U'
        DB      54h             ; 'T'
        DB      45h             ; 'E'
        DB      52h             ; 'R'
        DB      21h             ; '!'
        DB      0Ah
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      6Bh             ; 'k'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      75h             ; 'u'
        DB      72h             ; 'r'
        DB      6Eh             ; 'n'
        DB      21h             ; '!'
        DB      3Eh             ; '>'
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      70h             ; 'p'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      61h             ; 'a'
        DB      6Bh             ; 'k'
        DB      2Eh             ; '.'
        DB      0Ah
        DB      54h             ; 'T'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      45h             ; 'E'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      2Eh             ; '.'
        DB      25h             ; '%'
        DB      2Ah             ; '*'
        DB      49h             ; 'I'
        DB      27h             ; '''
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      42h             ; 'B'
        DB      4Fh             ; 'O'
        DB      54h             ; 'T'
        DB      54h             ; 'T'
        DB      4Fh             ; 'O'
        DB      4Dh             ; 'M'
        DB      4Ch             ; 'L'
        DB      45h             ; 'E'
        DB      53h             ; 'S'
        DB      53h             ; 'S'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      5Ah             ; 'Z'
        DB      2Ah             ; '*'
        DB      49h             ; 'I'
        DB      27h             ; '''
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Ah             ; 'j'
        DB      75h             ; 'u'
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      72h             ; 'r'
        DB      69h             ; 'i'
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      42h             ; 'B'
        DB      4Fh             ; 'O'
        DB      54h             ; 'T'
        DB      54h             ; 'T'
        DB      4Fh             ; 'O'
        DB      4Dh             ; 'M'
        DB      4Ch             ; 'L'
        DB      45h             ; 'E'
        DB      53h             ; 'S'
        DB      53h             ; 'S'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      0Ah
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      27h             ; '''
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      6Bh             ; 'k'
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      6Eh             ; 'n'
        DB      21h             ; '!'
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      75h             ; 'u'
        DB      6Eh             ; 'n'
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      75h             ; 'u'
        DB      7Ah             ; 'z'
        DB      7Ah             ; 'z'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      64h             ; 'd'
        DB      1Bh
        DB      2Ah             ; '*'
        DB      49h             ; 'I'
        DB      27h             ; '''
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      72h             ; 'r'
        DB      69h             ; 'i'
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      44h             ; 'D'
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      72h             ; 'r'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      0Ah
        DB      75h             ; 'u'
        DB      6Eh             ; 'n'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      64h             ; 'd'
        DB      61h             ; 'a'
        DB      62h             ; 'b'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      74h             ; 't'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      65h             ; 'e'
        DB      78h             ; 'x'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      2Eh             ; '.'
        DB      00h
        DB      0Fh
        DB      4Eh             ; 'N'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      70h             ; 'p'
        DB      70h             ; 'p'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      73h             ; 's'
        DB      0Eh
        DB      43h             ; 'C'
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      70h             ; 'p'
        DB      20h             ; ' '
        DB      27h             ; '''
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      6Eh             ; 'n'
        DB      21h             ; '!'
        DB      1Dh
        DB      42h             ; 'B'
        DB      4Fh             ; 'O'
        DB      59h             ; 'Y'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      70h             ; 'p'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      21h             ; '!'
        DB      2Eh             ; '.'
        DB      44h             ; 'D'
        DB      72h             ; 'r'
        DB      61h             ; 'a'
        DB      67h             ; 'g'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      77h             ; 'w'
        DB      61h             ; 'a'
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      26h             ; '&'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      74h             ; 't'
        DB      61h             ; 'a'
        DB      63h             ; 'c'
        DB      6Bh             ; 'k'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      21h             ; '!'
        DB      0Dh
        DB      4Ch             ; 'L'
        DB      6Fh             ; 'o'
        DB      63h             ; 'c'
        DB      6Bh             ; 'k'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      73h             ; 's'
        DB      12h
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      27h             ; '''
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      63h             ; 'c'
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      40h             ; '@'
        DB      54h             ; 'T'
        DB      49h             ; 'I'
        DB      4Dh             ; 'M'
        DB      42h             ; 'B'
        DB      45h             ; 'E'
        DB      52h             ; 'R'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      53h             ; 'S'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      70h             ; 'p'
        DB      20h             ; ' '
        DB      26h             ; '&'
        DB      20h             ; ' '
        DB      76h             ; 'v'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      77h             ; 'w'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      70h             ; 'p'
        DB      07h
        DB      54h             ; 'T'
        DB      49h             ; 'I'
        DB      4Dh             ; 'M'
        DB      42h             ; 'B'
        DB      45h             ; 'E'
        DB      52h             ; 'R'
        DB      21h             ; '!'
        DB      0Bh
        DB      4Ch             ; 'L'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      70h             ; 'p'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      66h             ; 'f'
        DB      2Bh             ; '+'
        DB      4Ch             ; 'L'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      70h             ; 'p'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      75h             ; 'u'
        DB      72h             ; 'r'
        DB      6Eh             ; 'n'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      6Fh             ; 'o'
        DB      6Ch             ; 'l'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      6Ch             ; 'l'
        DB      75h             ; 'u'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      2Eh             ; '.'
        DB      13h
        DB      49h             ; 'I'
        DB      27h             ; '''
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      70h             ; 'p'
        DB      69h             ; 'i'
        DB      64h             ; 'd'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      24h             ; '$'
        DB      0Ah
        DB      20h             ; ' '
        DB      4Dh             ; 'M'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      4Ch             ; 'L'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Eh             ; 'n'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      4Eh             ; 'N'
        DB      46h             ; 'F'
        DB      45h             ; 'E'
        DB      43h             ; 'C'
        DB      54h             ; 'T'
        DB      45h             ; 'E'
        DB      44h             ; 'D'
        DB      21h             ; '!'
        DB      20h             ; ' '
        DB      0Ah
        DB      23h             ; '#'
        DB      4Dh             ; 'M'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      6Fh             ; 'o'
        DB      64h             ; 'd'
        DB      79h             ; 'y'
        DB      21h             ; '!'
        DB      25h             ; '%'
        DB      42h             ; 'B'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      70h             ; 'p'
        DB      2Eh             ; '.'
        DB      0Dh
        DB      42h             ; 'B'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      46h             ; 'F'
        DB      69h             ; 'i'
        DB      72h             ; 'r'
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      65h             ; 'e'
        DB      6Dh             ; 'm'
        DB      70h             ; 'p'
        DB      74h             ; 't'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      61h             ; 'a'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      2Eh             ; '.'
        DB      27h             ; '''
        DB      54h             ; 'T'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      75h             ; 'u'
        DB      66h             ; 'f'
        DB      66h             ; 'f'
        DB      6Fh             ; 'o'
        DB      63h             ; 'c'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      70h             ; 'p'
        DB      70h             ; 'p'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      25h             ; '%'
        DB      53h             ; 'S'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      27h             ; '''
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      6Ch             ; 'l'
        DB      64h             ; 'd'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      76h             ; 'v'
        DB      69h             ; 'i'
        DB      62h             ; 'b'
        DB      72h             ; 'r'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      18h
        DB      6Eh             ; 'n'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      68h             ; 'h'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      13h
        DB      47h             ; 'G'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      64h             ; 'd'
        DB      64h             ; 'd'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      75h             ; 'u'
        DB      70h             ; 'p'
        DB      0Ch
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      73h             ; 's'
        DB      21h             ; '!'
        DB      2Dh             ; '-'
        DB      67h             ; 'g'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      61h             ; 'a'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      66h             ; 'f'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      75h             ; 'u'
        DB      72h             ; 'r'
        DB      6Eh             ; 'n'
        DB      25h             ; '%'
        DB      47h             ; 'G'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      73h             ; 's'
        DB      69h             ; 'i'
        DB      70h             ; 'p'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      28h             ; '('
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      6Bh             ; 'k'
        DB      20h             ; ' '
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      29h             ; ')'
        DB      11h
        DB      54h             ; 'T'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      27h             ; '''
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      6Eh             ; 'n'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      04h
        DB      48h             ; 'H'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      3Fh             ; '?'
        DB      11h
        DB      42h             ; 'B'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      27h             ; '''
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      30h             ; '0'
        DB      22h             ; '"'
        DB      44h             ; 'D'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      27h             ; '''
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      79h             ; 'y'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      64h             ; 'd'
        DB      21h             ; '!'
        DB      20h             ; ' '
        DB      44h             ; 'D'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      76h             ; 'v'
        DB      61h             ; 'a'
        DB      21h             ; '!'
        DB      3Fh             ; '?'
        DB      22h             ; '"'
        DB      27h             ; '''
        DB      42h             ; 'B'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      64h             ; 'd'
        DB      64h             ; 'd'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      74h             ; 't'
        DB      61h             ; 'a'
        DB      63h             ; 'c'
        DB      6Bh             ; 'k'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      21h             ; '!'
        DB      18h
        DB      49h             ; 'I'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Fh             ; 'o'
        DB      61h             ; 'a'
        DB      6Bh             ; 'k'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      2Ah             ; '*'
        DB      49h             ; 'I'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      32h             ; '2'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      64h             ; 'd'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      6Ch             ; 'l'
        DB      69h             ; 'i'
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      3Ah             ; ':'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      54h             ; 'T'
        DB      20h             ; ' '
        DB      54h             ; 'T'
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      45h             ; 'E'
        DB      1Eh
        DB      4Fh             ; 'O'
        DB      48h             ; 'H'
        DB      20h             ; ' '
        DB      4Eh             ; 'N'
        DB      4Fh             ; 'O'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      42h             ; 'B'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      64h             ; 'd'
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      43h             ; 'C'
        DB      52h             ; 'R'
        DB      41h             ; 'A'
        DB      53h             ; 'S'
        DB      48h             ; 'H'
        DB      21h             ; '!'
        DB      0Ah
        DB      49h             ; 'I'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      76h             ; 'v'
        DB      79h             ; 'y'
        DB      21h             ; '!'
        DB      1Dh
        DB      53h             ; 'S'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      76h             ; 'v'
        DB      79h             ; 'y'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      2Eh             ; '.'
        DB      15h
        DB      54h             ; 'T'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      70h             ; 'p'
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      51h             ; 'Q'
        DB      55h             ; 'U'
        DB      49h             ; 'I'
        DB      54h             ; 'T'
        DB      34h             ; '4'
        DB      4Dh             ; 'M'
        DB      69h             ; 'i'
        DB      72h             ; 'r'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      4Dh             ; 'M'
        DB      49h             ; 'I'
        DB      4Ch             ; 'L'
        DB      4Ch             ; 'L'
        DB      49h             ; 'I'
        DB      4Fh             ; 'O'
        DB      4Eh             ; 'N'
        DB      20h             ; ' '
        DB      70h             ; 'p'
        DB      69h             ; 'i'
        DB      65h             ; 'e'
        DB      63h             ; 'c'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      2Fh             ; '/'
        DB      4Dh             ; 'M'
        DB      69h             ; 'i'
        DB      72h             ; 'r'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      74h             ; 't'
        DB      6Ch             ; 'l'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      72h             ; 'r'
        DB      75h             ; 'u'
        DB      67h             ; 'g'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      68h             ; 'h'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      75h             ; 'u'
        DB      70h             ; 'p'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      73h             ; 's'
        DB      3Ah             ; ':'
        DB      19h
        DB      59h             ; 'Y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      2Ah             ; '*'
        DB      41h             ; 'A'
        DB      4Ch             ; 'L'
        DB      4Ch             ; 'L'
        DB      2Ah             ; '*'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      75h             ; 'u'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      2Eh             ; '.'
        DB      24h             ; '$'
        DB      49h             ; 'I'
        DB      27h             ; '''
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      6Eh             ; 'n'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      72h             ; 'r'
        DB      79h             ; 'y'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      78h             ; 'x'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      61h             ; 'a'
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      79h             ; 'y'
        DB      21h             ; '!'
        DB      25h             ; '%'
        DB      49h             ; 'I'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      6Eh             ; 'n'
        DB      27h             ; '''
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      21h             ; '!'
        DB      1Eh
        DB      54h             ; 'T'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      75h             ; 'u'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      72h             ; 'r'
        DB      69h             ; 'i'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      75h             ; 'u'
        DB      70h             ; 'p'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      66h             ; 'f'
        DB      2Eh             ; '.'
        DB      2Fh             ; '/'
        DB      42h             ; 'B'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      74h             ; 't'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      46h             ; 'F'
        DB      45h             ; 'E'
        DB      4Ch             ; 'L'
        DB      4Ch             ; 'L'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      21h             ; '!'
        DB      3Ah             ; ':'
        DB      22h             ; '"'
        DB      20h             ; ' '
        DB      44h             ; 'D'
        DB      52h             ; 'R'
        DB      41h             ; 'A'
        DB      47h             ; 'G'
        DB      4Fh             ; 'O'
        DB      4Eh             ; 'N'
        DB      20h             ; ' '
        DB      53h             ; 'S'
        DB      54h             ; 'T'
        DB      49h             ; 'I'
        DB      4Eh             ; 'N'
        DB      47h             ; 'G'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      61h             ; 'a'
        DB      64h             ; 'd'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      27h             ; '''
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      70h             ; 'p'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      2Eh             ; '.'
        DB      4Ch             ; 'L'
        DB      54h             ; 'T'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      74h             ; 't'
        DB      61h             ; 'a'
        DB      63h             ; 'c'
        DB      6Bh             ; 'k'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      72h             ; 'r'
        DB      61h             ; 'a'
        DB      67h             ; 'g'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      6Eh             ; 'n'
        DB      6Fh             ; 'o'
        DB      79h             ; 'y'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      75h             ; 'u'
        DB      70h             ; 'p'
        DB      0Ah
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      6Ch             ; 'l'
        DB      79h             ; 'y'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      77h             ; 'w'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      16h
        DB      4Ch             ; 'L'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      70h             ; 'p'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      6Eh             ; 'n'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      75h             ; 'u'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      26h             ; '&'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      19h
        DB      0Ah
        DB      49h             ; 'I'
        DB      27h             ; '''
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      0Ah
        DB      3Bh             ; ';'
        DB      54h             ; 'T'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      27h             ; '''
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      72h             ; 'r'
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      68h             ; 'h'
        DB      74h             ; 't'
        DB      21h             ; '!'
        DB      20h             ; ' '
        DB      4Dh             ; 'M'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      6Ch             ; 'l'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      3Fh             ; '?'
        DB      1Eh
        DB      4Dh             ; 'M'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      3Fh             ; '?'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      17h
        DB      54h             ; 'T'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      72h             ; 'r'
        DB      79h             ; 'y'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      68h             ; 'h'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      69h             ; 'i'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      2Eh             ; '.'
        DB      38h             ; '8'
        DB      41h             ; 'A'
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      47h             ; 'G'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      69h             ; 'i'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      70h             ; 'p'
        DB      70h             ; 'p'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      73h             ; 's'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      70h             ; 'p'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      76h             ; 'v'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      2Eh             ; '.'
        DB      5Fh             ; '_'
        DB      41h             ; 'A'
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      47h             ; 'G'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      69h             ; 'i'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      70h             ; 'p'
        DB      70h             ; 'p'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      73h             ; 's'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      42h             ; 'B'
        DB      6Fh             ; 'o'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      27h             ; '''
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      66h             ; 'f'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      68h             ; 'h'
        DB      22h             ; '"'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      61h             ; 'a'
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      0Ah
        DB      73h             ; 's'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      4Dh             ; 'M'
        DB      45h             ; 'E'
        DB      22h             ; '"'
        DB      20h             ; ' '
        DB      76h             ; 'v'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      68h             ; 'h'
        DB      21h             ; '!'
        DB      10h
        DB      4Eh             ; 'N'
        DB      6Fh             ; 'o'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      2Eh             ; '.'
        DB      09h
        DB      4Eh             ; 'N'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      2Eh             ; '.'
        DB      0Dh
        DB      54h             ; 'T'
        DB      72h             ; 'r'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      77h             ; 'w'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      70h             ; 'p'
        DB      09h
        DB      53h             ; 'S'
        DB      69h             ; 'i'
        DB      7Ah             ; 'z'
        DB      7Ah             ; 'z'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      62h             ; 'b'
        DB      53h             ; 'S'
        DB      75h             ; 'u'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      79h             ; 'y'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      27h             ; '''
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      65h             ; 'e'
        DB      78h             ; 'x'
        DB      70h             ; 'p'
        DB      65h             ; 'e'
        DB      63h             ; 'c'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      73h             ; 's'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      20h             ; ' '
        DB      65h             ; 'e'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      74h             ; 't'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      0Ah
        DB      70h             ; 'p'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      62h             ; 'b'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      67h             ; 'g'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      28h             ; '('
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      6Bh             ; 'k'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      29h             ; ')'
        DB      29h             ; ')'
        DB      54h             ; 'T'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      6Ch             ; 'l'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      33h             ; '3'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      61h             ; 'a'
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      44h             ; 'D'
        DB      72h             ; 'r'
        DB      61h             ; 'a'
        DB      67h             ; 'g'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      21h             ; '!'
        DB      22h             ; '"'
        DB      52h             ; 'R'
        DB      65h             ; 'e'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      6Dh             ; 'm'
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      77h             ; 'w'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      48h             ; 'H'
        DB      45h             ; 'E'
        DB      4Ch             ; 'L'
        DB      50h             ; 'P'
        DB      22h             ; '"'
        DB      1Ch
        DB      52h             ; 'R'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      21h             ; '!'
        DB      24h             ; '$'
        DB      59h             ; 'Y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      67h             ; 'g'
        DB      69h             ; 'i'
        DB      63h             ; 'c'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      64h             ; 'd'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      14h
        DB      41h             ; 'A'
        DB      20h             ; ' '
        DB      76h             ; 'v'
        DB      6Fh             ; 'o'
        DB      69h             ; 'i'
        DB      63h             ; 'c'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      42h             ; 'B'
        DB      4Fh             ; 'O'
        DB      4Fh             ; 'O'
        DB      4Fh             ; 'O'
        DB      4Fh             ; 'O'
        DB      4Dh             ; 'M'
        DB      53h             ; 'S'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      74h             ; 't'
        DB      3Ah             ; ':'
        DB      15h
        DB      70h             ; 'p'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      1Fh
        DB      53h             ; 'S'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      72h             ; 'r'
        DB      79h             ; 'y'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      6Ch             ; 'l'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      78h             ; 'x'
        DB      2Eh             ; '.'
        DB      1Bh
        DB      4Dh             ; 'M'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      69h             ; 'i'
        DB      63h             ; 'c'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      2Eh             ; '.'
        DB      18h
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      27h             ; '''
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      6Bh             ; 'k'
        DB      6Eh             ; 'n'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      9Bh
        DB      0Ah
        DB      57h             ; 'W'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      63h             ; 'c'
        DB      6Fh             ; 'o'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      64h             ; 'd'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      75h             ; 'u'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Eh             ; 'n'
        DB      75h             ; 'u'
        DB      6Dh             ; 'm'
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      3Ah             ; ':'
        DB      20h             ; ' '
        DB      31h             ; '1'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      41h             ; 'A'
        DB      44h             ; 'D'
        DB      56h             ; 'V'
        DB      45h             ; 'E'
        DB      4Eh             ; 'N'
        DB      54h             ; 'T'
        DB      55h             ; 'U'
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      4Ch             ; 'L'
        DB      41h             ; 'A'
        DB      4Eh             ; 'N'
        DB      44h             ; 'D'
        DB      22h             ; '"'
        DB      2Eh             ; '.'
        DB      0Ah
        DB      49h             ; 'I'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      64h             ; 'd'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      75h             ; 'u'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      27h             ; '''
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      2Ah             ; '*'
        DB      54h             ; 'T'
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      41h             ; 'A'
        DB      53h             ; 'S'
        DB      55h             ; 'U'
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      53h             ; 'S'
        DB      2Ah             ; '*'
        DB      20h             ; ' '
        DB      26h             ; '&'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      77h             ; 'w'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      2Eh             ; '.'
        DB      0Ah
        DB      0Ah
        DB      54h             ; 'T'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      27h             ; '''
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      3Ah             ; ':'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      53h             ; 'S'
        DB      43h             ; 'C'
        DB      4Fh             ; 'O'
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      22h             ; '"'
        DB      0Bh
        DB      42h             ; 'B'
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      75h             ; 'u'
        DB      70h             ; 'p'
        DB      21h             ; '!'
        DB      23h             ; '#'
        DB      46h             ; 'F'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      68h             ; 'h'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      63h             ; 'c'
        DB      61h             ; 'a'
        DB      70h             ; 'p'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      61h             ; 'a'
        DB      63h             ; 'c'
        DB      6Bh             ; 'k'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      2Eh             ; '.'
        DB      02h
        DB      4Fh             ; 'O'
        DB      4Bh             ; 'K'
        DB      16h
        DB      48h             ; 'H'
        DB      75h             ; 'u'
        DB      68h             ; 'h'
        DB      3Fh             ; '?'
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      27h             ; '''
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      6Bh             ; 'k'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Fh             ; 'o'
        DB      21h             ; '!'
        DB      21h             ; '!'
        DB      59h             ; 'Y'
        DB      6Fh             ; 'o'
        DB      75h             ; 'u'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      68h             ; 'h'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      72h             ; 'r'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      65h             ; 'e'
        DB      78h             ; 'x'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      73h             ; 's'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      05h
        DB      57h             ; 'W'
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      3Fh             ; '?'
        DB      0Fh
        DB      4Fh             ; 'O'
        DB      4Bh             ; 'K'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      2Eh             ; '.'
        DB      0A2h
        DB      0Ah
        DB      0Ah
        DB      54h             ; 'T'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      48h             ; 'H'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      73h             ; 's'
        DB      3Ah             ; ':'
        DB      0Ah
        DB      0Ah
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      46h             ; 'F'
        DB      52h             ; 'R'
        DB      4Fh             ; 'O'
        DB      4Dh             ; 'M'
        DB      20h             ; ' '
        DB      54h             ; 'T'
        DB      48h             ; 'H'
        DB      45h             ; 'E'
        DB      20h             ; ' '
        DB      53h             ; 'S'
        DB      4Fh             ; 'O'
        DB      52h             ; 'R'
        DB      43h             ; 'C'
        DB      45h             ; 'E'
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      52h             ; 'R'
        DB      20h             ; ' '
        DB      55h             ; 'U'
        DB      53h             ; 'S'
        DB      45h             ; 'E'
        DB      52h             ; 'R'
        DB      53h             ; 'S'
        DB      20h             ; ' '
        DB      47h             ; 'G'
        DB      52h             ; 'R'
        DB      4Fh             ; 'O'
        DB      55h             ; 'U'
        DB      50h             ; 'P'
        DB      20h             ; ' '
        DB      28h             ; '('
        DB      41h             ; 'A'
        DB      55h             ; 'U'
        DB      53h             ; 'S'
        DB      54h             ; 'T'
        DB      52h             ; 'R'
        DB      41h             ; 'A'
        DB      4Ch             ; 'L'
        DB      49h             ; 'I'
        DB      41h             ; 'A'
        DB      29h             ; ')'
        DB      0Ah
        DB      0Ah
        DB      53h             ; 'S'
        DB      79h             ; 'y'
        DB      64h             ; 'd'
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      42h             ; 'B'
        DB      72h             ; 'r'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      20h             ; ' '
        DB      0Ah
        DB      0Ah
        DB      49h             ; 'I'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      73h             ; 's'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      73h             ; 's'
        DB      3Ah             ; ':'
        DB      0Ah
        DB      0Ah
        DB      44h             ; 'D'
        DB      4Fh             ; 'O'
        DB      4Eh             ; 'N'
        DB      27h             ; '''
        DB      54h             ; 'T'
        DB      20h             ; ' '
        DB      43h             ; 'C'
        DB      4Fh             ; 'O'
        DB      50h             ; 'P'
        DB      59h             ; 'Y'
        DB      20h             ; ' '
        DB      4Fh             ; 'O'
        DB      52h             ; 'R'
        DB      20h             ; ' '
        DB      47h             ; 'G'
        DB      49h             ; 'I'
        DB      56h             ; 'V'
        DB      45h             ; 'E'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      57h             ; 'W'
        DB      41h             ; 'A'
        DB      59h             ; 'Y'
        DB      20h             ; ' '
        DB      54h             ; 'T'
        DB      48h             ; 'H'
        DB      45h             ; 'E'
        DB      20h             ; ' '
        DB      50h             ; 'P'
        DB      52h             ; 'R'
        DB      4Fh             ; 'O'
        DB      47h             ; 'G'
        DB      52h             ; 'R'
        DB      41h             ; 'A'
        DB      4Dh             ; 'M'
        DB      2Eh             ; '.'
        DB      0Ah
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      3Ah             ; ':'
        DB      41h             ; 'A'
        DB      64h             ; 'd'
        DB      76h             ; 'v'
        DB      31h             ; '1'
        DB      20h             ; ' '
        DB      52h             ; 'R'
        DB      65h             ; 'e'
        DB      66h             ; 'f'
        DB      2Eh             ; '.'
        DB      31h             ; '1'
        DB      31h             ; '1'
        DB      33h             ; '3'
        DB      37h             ; '7'
        DB      20h             ; ' '
        DB      21h             ; '!'
        DB      0Ah
        DB      0Ah
        DB      10h
        DB      54h             ; 'T'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      78h             ; 'x'
        DB      20h             ; ' '
        DB      76h             ; 'v'
        DB      69h             ; 'i'
        DB      62h             ; 'b'
        DB      72h             ; 'r'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      21h             ; '!'
        DB      15h
        DB      49h             ; 'I'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Eh             ; 'n'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      70h             ; 'p'
        DB      65h             ; 'e'
        DB      63h             ; 'c'
        DB      69h             ; 'i'
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      13h
        DB      47h             ; 'G'
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      2Ah             ; '*'
        DB      46h             ; 'F'
        DB      49h             ; 'I'
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      53h             ; 'S'
        DB      54h             ; 'T'
        DB      4Fh             ; 'O'
        DB      4Eh             ; 'N'
        DB      45h             ; 'E'
        DB      2Ah             ; '*'
        DB      09h
        DB      44h             ; 'D'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      6Bh             ; 'k'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      14h
        DB      2Ah             ; '*'
        DB      50h             ; 'P'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      52h             ; 'R'
        DB      55h             ; 'U'
        DB      42h             ; 'B'
        DB      49h             ; 'I'
        DB      45h             ; 'E'
        DB      53h             ; 'S'
        DB      2Ah             ; '*'
        DB      2Fh             ; '/'
        DB      52h             ; 'R'
        DB      55h             ; 'U'
        DB      42h             ; 'B'
        DB      2Fh             ; '/'
        DB      02h
        DB      1Dh
        DB      53h             ; 'S'
        DB      70h             ; 'p'
        DB      69h             ; 'i'
        DB      64h             ; 'd'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      65h             ; 'e'
        DB      62h             ; 'b'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      72h             ; 'r'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      2Bh             ; '+'
        DB      2Dh             ; '-'
        DB      48h             ; 'H'
        DB      4Fh             ; 'O'
        DB      4Ch             ; 'L'
        DB      4Ch             ; 'L'
        DB      4Fh             ; 'O'
        DB      57h             ; 'W'
        DB      2Dh             ; '-'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      75h             ; 'u'
        DB      6Dh             ; 'm'
        DB      70h             ; 'p'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      0Ch
        DB      43h             ; 'C'
        DB      79h             ; 'y'
        DB      70h             ; 'p'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      05h
        DB      57h             ; 'W'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      16h
        DB      45h             ; 'E'
        DB      76h             ; 'v'
        DB      69h             ; 'i'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      75h             ; 'u'
        DB      64h             ; 'd'
        DB      2Fh             ; '/'
        DB      4Dh             ; 'M'
        DB      55h             ; 'U'
        DB      44h             ; 'D'
        DB      2Fh             ; '/'
        DB      07h
        DB      12h
        DB      2Ah             ; '*'
        DB      47h             ; 'G'
        DB      4Fh             ; 'O'
        DB      4Ch             ; 'L'
        DB      44h             ; 'D'
        DB      45h             ; 'E'
        DB      4Eh             ; 'N'
        DB      20h             ; ' '
        DB      46h             ; 'F'
        DB      49h             ; 'I'
        DB      53h             ; 'S'
        DB      48h             ; 'H'
        DB      2Ah             ; '*'
        DB      2Fh             ; '/'
        DB      46h             ; 'F'
        DB      49h             ; 'I'
        DB      53h             ; 'S'
        DB      2Fh             ; '/'
        DB      08h
        DB      13h
        DB      4Ch             ; 'L'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      72h             ; 'r'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      70h             ; 'p'
        DB      2Fh             ; '/'
        DB      4Ch             ; 'L'
        DB      41h             ; 'A'
        DB      4Dh             ; 'M'
        DB      2Fh             ; '/'
        DB      09h
        DB      1Dh
        DB      4Fh             ; 'O'
        DB      6Ch             ; 'l'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      72h             ; 'r'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      70h             ; 'p'
        DB      2Fh             ; '/'
        DB      4Ch             ; 'L'
        DB      41h             ; 'A'
        DB      4Dh             ; 'M'
        DB      2Fh             ; '/'
        DB      0Ah
        DB      2Ah             ; '*'
        DB      52h             ; 'R'
        DB      75h             ; 'u'
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      78h             ; 'x'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      28h             ; '('
        DB      4Dh             ; 'M'
        DB      61h             ; 'a'
        DB      67h             ; 'g'
        DB      69h             ; 'i'
        DB      63h             ; 'c'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      42h             ; 'B'
        DB      55h             ; 'U'
        DB      4Eh             ; 'N'
        DB      59h             ; 'Y'
        DB      4Fh             ; 'O'
        DB      4Eh             ; 'N'
        DB      22h             ; '"'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      29h             ; ')'
        DB      2Fh             ; '/'
        DB      41h             ; 'A'
        DB      58h             ; 'X'
        DB      45h             ; 'E'
        DB      2Fh             ; '/'
        DB      0Bh
        DB      14h
        DB      57h             ; 'W'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      74h             ; 't'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      2Fh             ; '/'
        DB      42h             ; 'B'
        DB      4Fh             ; 'O'
        DB      54h             ; 'T'
        DB      2Fh             ; '/'
        DB      0Ch
        DB      11h
        DB      45h             ; 'E'
        DB      6Dh             ; 'm'
        DB      70h             ; 'p'
        DB      74h             ; 't'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      74h             ; 't'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      2Fh             ; '/'
        DB      42h             ; 'B'
        DB      4Fh             ; 'O'
        DB      54h             ; 'T'
        DB      2Fh             ; '/'
        DB      0Dh
        DB      1Ah
        DB      52h             ; 'R'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      74h             ; 't'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      79h             ; 'y'
        DB      73h             ; 's'
        DB      2Fh             ; '/'
        DB      4Bh             ; 'K'
        DB      45h             ; 'E'
        DB      59h             ; 'Y'
        DB      2Fh             ; '/'
        DB      0Eh
        DB      2Eh             ; '.'
        DB      53h             ; 'S'
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      4Ch             ; 'L'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      2Ah             ; '*'
        DB      54h             ; 'T'
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      41h             ; 'A'
        DB      53h             ; 'S'
        DB      55h             ; 'U'
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      53h             ; 'S'
        DB      2Ah             ; '*'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      2Ch             ; ','
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      3Ah             ; ':'
        DB      20h             ; ' '
        DB      53h             ; 'S'
        DB      43h             ; 'C'
        DB      4Fh             ; 'O'
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      22h             ; '"'
        DB      0Bh
        DB      4Ch             ; 'L'
        DB      6Fh             ; 'o'
        DB      63h             ; 'c'
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      1Fh
        DB      4Fh             ; 'O'
        DB      70h             ; 'p'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      77h             ; 'w'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      79h             ; 'y'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      09h
        DB      53h             ; 'S'
        DB      77h             ; 'w'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      70h             ; 'p'
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      11h
        DB      2Ah             ; '*'
        DB      47h             ; 'G'
        DB      4Fh             ; 'O'
        DB      4Ch             ; 'L'
        DB      44h             ; 'D'
        DB      45h             ; 'E'
        DB      4Eh             ; 'N'
        DB      20h             ; ' '
        DB      4Eh             ; 'N'
        DB      45h             ; 'E'
        DB      54h             ; 'T'
        DB      2Ah             ; '*'
        DB      2Fh             ; '/'
        DB      4Eh             ; 'N'
        DB      45h             ; 'E'
        DB      54h             ; 'T'
        DB      2Fh             ; '/'
        DB      13h
        DB      0Dh
        DB      4Ch             ; 'L'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      16h
        DB      49h             ; 'I'
        DB      6Eh             ; 'n'
        DB      66h             ; 'f'
        DB      65h             ; 'e'
        DB      63h             ; 'c'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      1Ch
        DB      50h             ; 'P'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      4Fh             ; 'O'
        DB      49h             ; 'I'
        DB      4Ch             ; 'L'
        DB      59h             ; 'Y'
        DB      22h             ; '"'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Ch             ; 'l'
        DB      69h             ; 'i'
        DB      6Dh             ; 'm'
        DB      65h             ; 'e'
        DB      2Fh             ; '/'
        DB      4Fh             ; 'O'
        DB      49h             ; 'I'
        DB      4Ch             ; 'L'
        DB      2Fh             ; '/'
        DB      16h
        DB      12h
        DB      2Ah             ; '*'
        DB      52h             ; 'R'
        DB      4Fh             ; 'O'
        DB      59h             ; 'Y'
        DB      41h             ; 'A'
        DB      4Ch             ; 'L'
        DB      20h             ; ' '
        DB      48h             ; 'H'
        DB      4Fh             ; 'O'
        DB      4Eh             ; 'N'
        DB      45h             ; 'E'
        DB      59h             ; 'Y'
        DB      2Ah             ; '*'
        DB      2Fh             ; '/'
        DB      48h             ; 'H'
        DB      4Fh             ; 'O'
        DB      4Eh             ; 'N'
        DB      2Fh             ; '/'
        DB      17h
        DB      12h
        DB      4Ch             ; 'L'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      66h             ; 'f'
        DB      72h             ; 'r'
        DB      69h             ; 'i'
        DB      63h             ; 'c'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      14h
        DB      56h             ; 'V'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      63h             ; 'c'
        DB      6Bh             ; 'k'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      15h
        DB      42h             ; 'B'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      74h             ; 't'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      2Fh             ; '/'
        DB      42h             ; 'B'
        DB      4Fh             ; 'O'
        DB      54h             ; 'T'
        DB      2Fh             ; '/'
        DB      1Ah
        DB      15h
        DB      4Ch             ; 'L'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      70h             ; 'p'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      72h             ; 'r'
        DB      61h             ; 'a'
        DB      67h             ; 'g'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      12h
        DB      46h             ; 'F'
        DB      6Ch             ; 'l'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      26h             ; '&'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      6Ch             ; 'l'
        DB      2Fh             ; '/'
        DB      46h             ; 'F'
        DB      4Ch             ; 'L'
        DB      49h             ; 'I'
        DB      2Fh             ; '/'
        DB      1Ch
        DB      18h
        DB      2Ah             ; '*'
        DB      54h             ; 'T'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      63h             ; 'c'
        DB      6Bh             ; 'k'
        DB      20h             ; ' '
        DB      50h             ; 'P'
        DB      45h             ; 'E'
        DB      52h             ; 'R'
        DB      53h             ; 'S'
        DB      49h             ; 'I'
        DB      41h             ; 'A'
        DB      4Eh             ; 'N'
        DB      20h             ; ' '
        DB      52h             ; 'R'
        DB      55h             ; 'U'
        DB      47h             ; 'G'
        DB      2Ah             ; '*'
        DB      2Fh             ; '/'
        DB      52h             ; 'R'
        DB      55h             ; 'U'
        DB      47h             ; 'G'
        DB      2Fh             ; '/'
        DB      1Dh
        DB      40h             ; '@'
        DB      53h             ; 'S'
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      6Eh             ; 'n'
        DB      3Ah             ; ':'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      67h             ; 'g'
        DB      69h             ; 'i'
        DB      63h             ; 'c'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      64h             ; 'd'
        DB      27h             ; '''
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      41h             ; 'A'
        DB      57h             ; 'W'
        DB      41h             ; 'A'
        DB      59h             ; 'Y'
        DB      21h             ; '!'
        DB      20h             ; ' '
        DB      4Ch             ; 'L'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      6Bh             ; 'k'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      22h             ; '"'
        DB      0Ah
        DB      28h             ; '('
        DB      52h             ; 'R'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      73h             ; 's'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      21h             ; '!'
        DB      29h             ; ')'
        DB      1Ah
        DB      44h             ; 'D'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      64h             ; 'd'
        DB      64h             ; 'd'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      2Fh             ; '/'
        DB      42h             ; 'B'
        DB      4Ch             ; 'L'
        DB      41h             ; 'A'
        DB      2Fh             ; '/'
        DB      1Fh
        DB      11h
        DB      42h             ; 'B'
        DB      72h             ; 'r'
        DB      69h             ; 'i'
        DB      63h             ; 'c'
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      75h             ; 'u'
        DB      70h             ; 'p'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      38h             ; '8'
        DB      53h             ; 'S'
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      49h             ; 'I'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      63h             ; 'c'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      6Dh             ; 'm'
        DB      75h             ; 'u'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      64h             ; 'd'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      49h             ; 'I'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      73h             ; 's'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      22h             ; '"'
        DB      0Eh
        DB      53h             ; 'S'
        DB      74h             ; 't'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      76h             ; 'v'
        DB      61h             ; 'a'
        DB      23h             ; '#'
        DB      42h             ; 'B'
        DB      72h             ; 'r'
        DB      69h             ; 'i'
        DB      63h             ; 'c'
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      75h             ; 'u'
        DB      70h             ; 'p'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      16h
        DB      4Ch             ; 'L'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      73h             ; 's'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      69h             ; 'i'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      72h             ; 'r'
        DB      69h             ; 'i'
        DB      63h             ; 'c'
        DB      6Bh             ; 'k'
        DB      73h             ; 's'
        DB      2Fh             ; '/'
        DB      42h             ; 'B'
        DB      52h             ; 'R'
        DB      49h             ; 'I'
        DB      2Fh             ; '/'
        DB      24h             ; '$'
        DB      11h
        DB      2Ah             ; '*'
        DB      47h             ; 'G'
        DB      4Fh             ; 'O'
        DB      4Ch             ; 'L'
        DB      44h             ; 'D'
        DB      20h             ; ' '
        DB      43h             ; 'C'
        DB      52h             ; 'R'
        DB      4Fh             ; 'O'
        DB      57h             ; 'W'
        DB      4Eh             ; 'N'
        DB      2Ah             ; '*'
        DB      2Fh             ; '/'
        DB      43h             ; 'C'
        DB      52h             ; 'R'
        DB      4Fh             ; 'O'
        DB      2Fh             ; '/'
        DB      25h             ; '%'
        DB      0Eh
        DB      2Ah             ; '*'
        DB      4Dh             ; 'M'
        DB      41h             ; 'A'
        DB      47h             ; 'G'
        DB      49h             ; 'I'
        DB      43h             ; 'C'
        DB      20h             ; ' '
        DB      4Dh             ; 'M'
        DB      49h             ; 'I'
        DB      52h             ; 'R'
        DB      52h             ; 'R'
        DB      4Fh             ; 'O'
        DB      52h             ; 'R'
        DB      2Ah             ; '*'
        DB      0Dh
        DB      53h             ; 'S'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      70h             ; 'p'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      17h
        DB      45h             ; 'E'
        DB      6Dh             ; 'm'
        DB      70h             ; 'p'
        DB      74h             ; 't'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      64h             ; 'd'
        DB      64h             ; 'd'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      2Fh             ; '/'
        DB      42h             ; 'B'
        DB      4Ch             ; 'L'
        DB      41h             ; 'A'
        DB      2Fh             ; '/'
        DB      28h             ; '('
        DB      11h
        DB      42h             ; 'B'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      6Bh             ; 'k'
        DB      65h             ; 'e'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      73h             ; 's'
        DB      2Fh             ; '/'
        DB      47h             ; 'G'
        DB      4Ch             ; 'L'
        DB      41h             ; 'A'
        DB      2Fh             ; '/'
        DB      29h             ; ')'
        DB      0Dh
        DB      20h             ; ' '
        DB      4Ch             ; 'L'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      2Fh             ; '/'
        DB      4Ch             ; 'L'
        DB      45h             ; 'E'
        DB      45h             ; 'E'
        DB      2Fh             ; '/'
        DB      2Ah             ; '*'
        DB      13h
        DB      53h             ; 'S'
        DB      6Ch             ; 'l'
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      68h             ; 'h'
        DB      74h             ; 't'
        DB      6Ch             ; 'l'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      7Ah             ; 'z'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      1Eh
        DB      2Ah             ; '*'
        DB      44h             ; 'D'
        DB      52h             ; 'R'
        DB      41h             ; 'A'
        DB      47h             ; 'G'
        DB      4Fh             ; 'O'
        DB      4Eh             ; 'N'
        DB      20h             ; ' '
        DB      45h             ; 'E'
        DB      47h             ; 'G'
        DB      47h             ; 'G'
        DB      53h             ; 'S'
        DB      2Ah             ; '*'
        DB      20h             ; ' '
        DB      28h             ; '('
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      72h             ; 'r'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      29h             ; ')'
        DB      2Fh             ; '/'
        DB      45h             ; 'E'
        DB      47h             ; 'G'
        DB      47h             ; 'G'
        DB      2Fh             ; '/'
        DB      2Ch             ; ','
        DB      1Ah
        DB      4Ch             ; 'L'
        DB      61h             ; 'a'
        DB      76h             ; 'v'
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      20h             ; ' '
        DB      62h             ; 'b'
        DB      72h             ; 'r'
        DB      69h             ; 'i'
        DB      63h             ; 'c'
        DB      6Bh             ; 'k'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      14h
        DB      2Ah             ; '*'
        DB      4Ah             ; 'J'
        DB      45h             ; 'E'
        DB      57h             ; 'W'
        DB      45h             ; 'E'
        DB      4Ch             ; 'L'
        DB      45h             ; 'E'
        DB      44h             ; 'D'
        DB      20h             ; ' '
        DB      46h             ; 'F'
        DB      52h             ; 'R'
        DB      55h             ; 'U'
        DB      49h             ; 'I'
        DB      54h             ; 'T'
        DB      2Ah             ; '*'
        DB      2Fh             ; '/'
        DB      46h             ; 'F'
        DB      52h             ; 'R'
        DB      55h             ; 'U'
        DB      2Fh             ; '/'
        DB      2Eh             ; '.'
        DB      1Fh
        DB      2Ah             ; '*'
        DB      53h             ; 'S'
        DB      6Dh             ; 'm'
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      74h             ; 't'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      75h             ; 'u'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      20h             ; ' '
        DB      42h             ; 'B'
        DB      4Ch             ; 'L'
        DB      55h             ; 'U'
        DB      45h             ; 'E'
        DB      20h             ; ' '
        DB      4Fh             ; 'O'
        DB      58h             ; 'X'
        DB      2Ah             ; '*'
        DB      2Fh             ; '/'
        DB      4Fh             ; 'O'
        DB      58h             ; 'X'
        DB      2Fh             ; '/'
        DB      2Fh             ; '/'
        DB      13h
        DB      2Ah             ; '*'
        DB      44h             ; 'D'
        DB      49h             ; 'I'
        DB      41h             ; 'A'
        DB      4Dh             ; 'M'
        DB      4Fh             ; 'O'
        DB      4Eh             ; 'N'
        DB      44h             ; 'D'
        DB      20h             ; ' '
        DB      52h             ; 'R'
        DB      49h             ; 'I'
        DB      4Eh             ; 'N'
        DB      47h             ; 'G'
        DB      2Ah             ; '*'
        DB      2Fh             ; '/'
        DB      52h             ; 'R'
        DB      49h             ; 'I'
        DB      4Eh             ; 'N'
        DB      2Fh             ; '/'
        DB      30h             ; '0'
        DB      17h
        DB      2Ah             ; '*'
        DB      44h             ; 'D'
        DB      49h             ; 'I'
        DB      41h             ; 'A'
        DB      4Dh             ; 'M'
        DB      4Fh             ; 'O'
        DB      4Eh             ; 'N'
        DB      44h             ; 'D'
        DB      20h             ; ' '
        DB      42h             ; 'B'
        DB      52h             ; 'R'
        DB      41h             ; 'A'
        DB      43h             ; 'C'
        DB      45h             ; 'E'
        DB      4Ch             ; 'L'
        DB      45h             ; 'E'
        DB      54h             ; 'T'
        DB      2Ah             ; '*'
        DB      2Fh             ; '/'
        DB      42h             ; 'B'
        DB      52h             ; 'R'
        DB      41h             ; 'A'
        DB      2Fh             ; '/'
        DB      31h             ; '1'
        DB      33h             ; '3'
        DB      53h             ; 'S'
        DB      74h             ; 't'
        DB      72h             ; 'r'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      63h             ; 'c'
        DB      72h             ; 'r'
        DB      61h             ; 'a'
        DB      74h             ; 't'
        DB      63h             ; 'c'
        DB      68h             ; 'h'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      63h             ; 'c'
        DB      6Bh             ; 'k'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      73h             ; 's'
        DB      3Ah             ; ':'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      41h             ; 'A'
        DB      4Ch             ; 'L'
        DB      41h             ; 'A'
        DB      44h             ; 'D'
        DB      49h             ; 'I'
        DB      4Eh             ; 'N'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      61h             ; 'a'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      22h             ; '"'
        DB      32h             ; '2'
        DB      53h             ; 'S'
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      4Ch             ; 'L'
        DB      49h             ; 'I'
        DB      4Dh             ; 'M'
        DB      42h             ; 'B'
        DB      4Fh             ; 'O'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      46h             ; 'F'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      72h             ; 'r'
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      68h             ; 'h'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      65h             ; 'e'
        DB      78h             ; 'x'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      69h             ; 'i'
        DB      76h             ; 'v'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      67h             ; 'g'
        DB      61h             ; 'a'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      21h             ; '!'
        DB      22h             ; '"'
        DB      28h             ; '('
        DB      53h             ; 'S'
        DB      6Dh             ; 'm'
        DB      6Fh             ; 'o'
        DB      6Bh             ; 'k'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      6Fh             ; 'o'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      2Eh             ; '.'
        DB      20h             ; ' '
        DB      70h             ; 'p'
        DB      69h             ; 'i'
        DB      65h             ; 'e'
        DB      63h             ; 'c'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      72h             ; 'r'
        DB      61h             ; 'a'
        DB      67h             ; 'g'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      67h             ; 'g'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      2Eh             ; '.'
        DB      24h             ; '$'
        DB      53h             ; 'S'
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      4Eh             ; 'N'
        DB      6Fh             ; 'o'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      77h             ; 'w'
        DB      69h             ; 'i'
        DB      6Dh             ; 'm'
        DB      6Dh             ; 'm'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      65h             ; 'e'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      22h             ; '"'
        DB      13h
        DB      41h             ; 'A'
        DB      72h             ; 'r'
        DB      72h             ; 'r'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      20h             ; ' '
        DB      70h             ; 'p'
        DB      6Fh             ; 'o'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      74h             ; 't'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      64h             ; 'd'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      6Eh             ; 'n'
        DB      0Eh
        DB      44h             ; 'D'
        DB      65h             ; 'e'
        DB      61h             ; 'a'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      66h             ; 'f'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      68h             ; 'h'
        DB      2Fh             ; '/'
        DB      46h             ; 'F'
        DB      49h             ; 'I'
        DB      53h             ; 'S'
        DB      2Fh             ; '/'
        DB      37h             ; '7'
        DB      1Bh
        DB      2Ah             ; '*'
        DB      46h             ; 'F'
        DB      49h             ; 'I'
        DB      52h             ; 'R'
        DB      45h             ; 'E'
        DB      53h             ; 'S'
        DB      54h             ; 'T'
        DB      4Fh             ; 'O'
        DB      4Eh             ; 'N'
        DB      45h             ; 'E'
        DB      2Ah             ; '*'
        DB      20h             ; ' '
        DB      28h             ; '('
        DB      63h             ; 'c'
        DB      6Fh             ; 'o'
        DB      6Ch             ; 'l'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      6Eh             ; 'n'
        DB      6Fh             ; 'o'
        DB      77h             ; 'w'
        DB      29h             ; ')'
        DB      2Fh             ; '/'
        DB      46h             ; 'F'
        DB      49h             ; 'I'
        DB      52h             ; 'R'
        DB      2Fh             ; '/'
        DB      38h             ; '8'
        DB      18h
        DB      53h             ; 'S'
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      50h             ; 'P'
        DB      61h             ; 'a'
        DB      75h             ; 'u'
        DB      6Ch             ; 'l'
        DB      27h             ; '''
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      70h             ; 'p'
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      63h             ; 'c'
        DB      65h             ; 'e'
        DB      22h             ; '"'
        DB      05h
        DB      54h             ; 'T'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      2Dh             ; '-'
        DB      53h             ; 'S'
        DB      69h             ; 'i'
        DB      67h             ; 'g'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      68h             ; 'h'
        DB      65h             ; 'e'
        DB      72h             ; 'r'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      79h             ; 'y'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      22h             ; '"'
        DB      4Fh             ; 'O'
        DB      70h             ; 'p'
        DB      70h             ; 'p'
        DB      6Fh             ; 'o'
        DB      73h             ; 's'
        DB      69h             ; 'i'
        DB      74h             ; 't'
        DB      65h             ; 'e'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      20h             ; ' '
        DB      4Ch             ; 'L'
        DB      49h             ; 'I'
        DB      47h             ; 'G'
        DB      48h             ; 'H'
        DB      54h             ; 'T'
        DB      20h             ; ' '
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      55h             ; 'U'
        DB      4Eh             ; 'N'
        DB      4Ch             ; 'L'
        DB      49h             ; 'I'
        DB      47h             ; 'G'
        DB      48h             ; 'H'
        DB      54h             ; 'T'
        DB      22h             ; '"'
        DB      0Fh
        DB      45h             ; 'E'
        DB      6Dh             ; 'm'
        DB      70h             ; 'p'
        DB      74h             ; 't'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      6Dh             ; 'm'
        DB      70h             ; 'p'
        DB      2Fh             ; '/'
        DB      4Ch             ; 'L'
        DB      41h             ; 'A'
        DB      4Dh             ; 'M'
        DB      2Fh             ; '/'
        DB      3Ch             ; '<'
        DB      1Ch
        DB      4Dh             ; 'M'
        DB      75h             ; 'u'
        DB      64h             ; 'd'
        DB      64h             ; 'd'
        DB      79h             ; 'y'
        DB      20h             ; ' '
        DB      77h             ; 'w'
        DB      6Fh             ; 'o'
        DB      72h             ; 'r'
        DB      74h             ; 't'
        DB      68h             ; 'h'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      73h             ; 's'
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      6Fh             ; 'o'
        DB      6Ch             ; 'l'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      72h             ; 'r'
        DB      75h             ; 'u'
        DB      67h             ; 'g'
        DB      2Fh             ; '/'
        DB      52h             ; 'R'
        DB      55h             ; 'U'
        DB      47h             ; 'G'
        DB      2Fh             ; '/'
        DB      3Dh             ; '='
        DB      20h             ; ' '
        DB      4Fh             ; 'O'
        DB      66h             ; 'f'
        DB      66h             ; 'f'
        DB      69h             ; 'i'
        DB      63h             ; 'c'
        DB      69h             ; 'i'
        DB      61h             ; 'a'
        DB      6Ch             ; 'l'
        DB      20h             ; ' '
        DB      6Ch             ; 'l'
        DB      6Fh             ; 'o'
        DB      6Fh             ; 'o'
        DB      6Bh             ; 'k'
        DB      69h             ; 'i'
        DB      6Eh             ; 'n'
        DB      67h             ; 'g'
        DB      20h             ; ' '
        DB      48h             ; 'H'
        DB      61h             ; 'a'
        DB      6Eh             ; 'n'
        DB      73h             ; 's'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      64h             ; 'd'
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      2Fh             ; '/'
        DB      48h             ; 'H'
        DB      41h             ; 'A'
        DB      4Eh             ; 'N'
        DB      2Fh             ; '/'
        DB      3Eh             ; '>'
        DB      04h
        DB      48h             ; 'H'
        DB      6Fh             ; 'o'
        DB      6Ch             ; 'l'
        DB      65h             ; 'e'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      04h
        DB      00h
        DB      04h
        DB      00h
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      00h
        DB      0Ah
        DB      00h
        DB      01h
        DB      00h
        DB      0Ah
        DB      00h
        DB      00h
        DB      00h
        DB      03h
        DB      00h
        DB      0Ah
        DB      00h
        DB      03h
        DB      00h
        DB      00h
        DB      00h
        DB      02h
        DB      00h
        DB      03h
        DB      00h
        DB      05h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      00h
        DB      12h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      00h
        DB      08h
        DB      00h
        DB      08h
        DB      00h
        DB      15h
        DB      00h
        DB      00h
        DB      00h
        DB      17h
        DB      00h
        DB      1Eh
        DB      00h
        DB      11h
        DB      00h
        DB      12h
        DB      00h
        DB      00h
        DB      00h
        DB      14h
        DB      00h
        DB      17h
        DB      00h
        DB      12h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      16h
        DB      00h
        DB      15h
        DB      00h
        DB      00h
        DB      00h
        DB      09h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      19h
        DB      00h
        DB      1Ah
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0Eh
        DB      00h
        DB      21h             ; '!'
        DB      00h
        DB      00h
        DB      00h
        DB      0Ah
        DB      00h
        DB      11h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      19h
        DB      00h
        DB      0Bh
        DB      00h
        DB      0Ch
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      1Dh
        DB      00h
        DB      1Dh
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0B7h
        DB      28h             ; '('
        DB      0CBh
        DB      28h             ; '('
        DB      0D5h
        DB      28h             ; '('
        DB      0EBh
        DB      28h             ; '('
        DB      09h
        DB      29h             ; ')'
        DB      35h             ; '5'
        DB      29h             ; ')'
        DB      42h             ; 'B'
        DB      29h             ; ')'
        DB      48h             ; 'H'
        DB      29h             ; ')'
        DB      60h             ; '`'
        DB      29h             ; ')'
        DB      74h             ; 't'
        DB      29h             ; ')'
        DB      89h
        DB      29h             ; ')'
        DB      0A8h
        DB      29h             ; ')'
        DB      0D4h
        DB      29h             ; ')'
        DB      0EAh
        DB      29h             ; ')'
        DB      0FDh
        DB      29h             ; ')'
        DB      19h
        DB      2Ah             ; '*'
        DB      48h             ; 'H'
        DB      2Ah             ; '*'
        DB      54h             ; 'T'
        DB      2Ah             ; '*'
        DB      74h             ; 't'
        DB      2Ah             ; '*'
        DB      7Eh             ; '~'
        DB      2Ah             ; '*'
        DB      91h
        DB      2Ah             ; '*'
        DB      9Fh
        DB      2Ah             ; '*'
        DB      0B6h
        DB      2Ah             ; '*'
        DB      0D4h
        DB      2Ah             ; '*'
        DB      0E8h
        DB      2Ah             ; '*'
        DB      0FBh
        DB      2Ah             ; '*'
        DB      10h
        DB      2Bh             ; '+'
        DB      27h             ; '''
        DB      2Bh             ; '+'
        DB      3Dh             ; '='
        DB      2Bh             ; '+'
        DB      51h             ; 'Q'
        DB      2Bh             ; '+'
        DB      6Bh             ; 'k'
        DB      2Bh             ; '+'
        DB      0ACh
        DB      2Bh             ; '+'
        DB      0C8h
        DB      2Bh             ; '+'
        DB      0DAh
        DB      2Bh             ; '+'
        DB      13h
        DB      2Ch             ; ','
        DB      22h             ; '"'
        DB      2Ch             ; ','
        DB      46h             ; 'F'
        DB      2Ch             ; ','
        DB      5Eh             ; '^'
        DB      2Ch             ; ','
        DB      71h             ; 'q'
        DB      2Ch             ; ','
        DB      80h
        DB      2Ch             ; ','
        DB      8Eh
        DB      2Ch             ; ','
        DB      0A7h
        DB      2Ch             ; ','
        DB      0BAh
        DB      2Ch             ; ','
        DB      0C9h
        DB      2Ch             ; ','
        DB      0DDh
        DB      2Ch             ; ','
        DB      0FDh
        DB      2Ch             ; ','
        DB      18h
        DB      2Dh             ; '-'
        DB      2Eh             ; '.'
        DB      2Dh             ; '-'
        DB      4Fh             ; 'O'
        DB      2Dh             ; '-'
        DB      64h             ; 'd'
        DB      2Dh             ; '-'
        DB      7Dh             ; '}'
        DB      2Dh             ; '-'
        DB      0B1h
        DB      2Dh             ; '-'
        DB      0E4h
        DB      2Dh             ; '-'
        DB      0Dh
        DB      2Eh             ; '.'
        DB      32h             ; '2'
        DB      2Eh             ; '.'
        DB      46h             ; 'F'
        DB      2Eh             ; '.'
        DB      56h             ; 'V'
        DB      2Eh             ; '.'
        DB      73h             ; 's'
        DB      2Eh             ; '.'
        DB      8Ch
        DB      2Eh             ; '.'
        DB      92h
        DB      2Eh             ; '.'
        DB      0C0h
        DB      2Eh             ; '.'
        DB      0D1h
        DB      2Eh             ; '.'
        DB      0EFh
        DB      2Eh             ; '.'
        DB      11h
        DB      2Fh             ; '/'
        DB      16h
        DB      2Fh             ; '/'
        DB      17h
        DB      2Fh             ; '/'
        DB      00h
        DB      00h
        DB      04h
        DB      00h
        DB      04h
        DB      00h
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      00h
        DB      0Ah
        DB      00h
        DB      01h
        DB      00h
        DB      0Ah
        DB      00h
        DB      00h
        DB      00h
        DB      03h
        DB      00h
        DB      0Ah
        DB      00h
        DB      03h
        DB      00h
        DB      00h
        DB      00h
        DB      02h
        DB      00h
        DB      03h
        DB      00h
        DB      05h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      00h
        DB      12h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      00h
        DB      08h
        DB      00h
        DB      08h
        DB      00h
        DB      15h
        DB      00h
        DB      00h
        DB      00h
        DB      17h
        DB      00h
        DB      1Eh
        DB      00h
        DB      11h
        DB      00h
        DB      12h
        DB      00h
        DB      00h
        DB      00h
        DB      14h
        DB      00h
        DB      17h
        DB      00h
        DB      12h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      16h
        DB      00h
        DB      15h
        DB      00h
        DB      00h
        DB      00h
        DB      09h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      19h
        DB      00h
        DB      1Ah
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0Eh
        DB      00h
        DB      21h             ; '!'
        DB      00h
        DB      00h
        DB      00h
        DB      0Ah
        DB      00h
        DB      11h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      19h
        DB      00h
        DB      0Bh
        DB      00h
        DB      0Ch
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      1Dh
        DB      00h
        DB      1Dh
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      1Dh
        DB      1Dh
        DB      0Ah
        DB      0Ah
        DB      0Ah
        DB      12h
        DB      12h
        DB      0Ah
        DB      0Ah
        DB      0Ah
        DB      0Ah
        DB      38h             ; '8'
        DB      22h             ; '"'
        DB      30h             ; '0'
        DB      0Eh
        DB      0Eh
        DB      3Ah             ; ':'
        DB      0Eh
        DB      01h
        DB      0Ah
        DB      0Ah
        DB      12h
        DB      0Eh
        DB      2Dh             ; '-'
        DB      01h
        DB      0Ah
        DB      12h
        DB      2Ah             ; '*'
        DB      0Ah
        DB      06h
        DB      06h
        DB      01h
        DB      01h
        DB      3Ah             ; ':'
        DB      01h
        DB      12h
        DB      0Ah
        DB      26h             ; '&'
        DB      01h
        DB      12h
        DB      37h             ; '7'
        DB      08h
        DB      45h             ; 'E'
        DB      25h             ; '%'
        DB      18h
        DB      45h             ; 'E'
        DB      38h             ; '8'
        DB      06h
        DB      39h             ; '9'
        DB      0Ah
        DB      20h             ; ' '
        DB      1Ah
        DB      0Ah
        DB      12h
        DB      07h
        DB      07h
        DB      21h             ; '!'
        DB      2Fh             ; '/'
        DB      2Fh             ; '/'
        DB      01h
        DB      0Ah
        DB      33h             ; '3'
        DB      12h
        DB      07h
        DB      45h             ; 'E'
        DB      01h
        DB      07h
        DB      2Dh             ; '-'
        DB      24h             ; '$'
        DB      01h
        DB      08h
        DB      27h             ; '''
        DB      27h             ; '''
        DB      2Ah             ; '*'
        DB      2Ah             ; '*'
        DB      2Ah             ; '*'
        DB      07h
        DB      1Bh
        DB      1Bh
        DB      08h
        DB      30h             ; '0'
        DB      30h             ; '0'
        DB      1Ch
        DB      0Ah
        DB      1Ch
        DB      1Ch
        DB      1Ch
        DB      1Ch
        DB      1Ch
        DB      33h             ; '3'
        DB      33h             ; '3'
        DB      1Bh
        DB      3Ch             ; '<'
        DB      30h             ; '0'
        DB      0Eh
        DB      2Dh             ; '-'
        DB      12h
        DB      2Dh             ; '-'
        DB      2Dh             ; '-'
        DB      07h
        DB      01h
        DB      2Fh             ; '/'
        DB      2Fh             ; '/'
        DB      2Fh             ; '/'
        DB      2Fh             ; '/'
        DB      2Fh             ; '/'
        DB      2Fh             ; '/'
        DB      2Fh             ; '/'
        DB      2Fh             ; '/'
        DB      2Fh             ; '/'
        DB      25h             ; '%'
        DB      01h
        DB      0Eh
        DB      25h             ; '%'
        DB      0Ah
        DB      01h
        DB      0Ah
        DB      0Eh
        DB      33h             ; '3'
        DB      30h             ; '0'
        DB      2Fh             ; '/'
        DB      18h
        DB      2Fh             ; '/'
        DB      30h             ; '0'
        DB      01h
        DB      0Ah
        DB      2Fh             ; '/'
        DB      08h
        DB      18h
        DB      07h
        DB      23h             ; '#'
        DB      1Ch
        DB      30h             ; '0'
        DB      2Ah             ; '*'
        DB      12h
        DB      00h
        DB      0Ah
        DB      0Ah
        DB      2Dh             ; '-'
        DB      26h             ; '&'
        DB      1Dh
        DB      06h
        DB      27h             ; '''
        DB      27h             ; '''
        DB      1Dh
        DB      07h
        DB      01h
        DB      4Bh             ; 'K'
        DB      0Ah
        DB      0Ah
        DB      08h
        DB      64h             ; 'd'
        DB      64h             ; 'd'
        DB      05h
        DB      08h
        DB      08h
        DB      64h             ; 'd'
        DB      32h             ; '2'
        DB      64h             ; 'd'
        DB      1Eh
        DB      32h             ; '2'
        DB      64h             ; 'd'
        DB      64h             ; 'd'
        DB      64h             ; 'd'
        DB      64h             ; 'd'
        DB      64h             ; 'd'
        DB      64h             ; 'd'
        DB      64h             ; 'd'
        DB      64h             ; 'd'
        DB      64h             ; 'd'
        DB      36h             ; '6'
        DB      39h             ; '9'
        DB      15h
        DB      2Ah             ; '*'
        DB      15h
        DB      2Ah             ; '*'
        DB      2Ah             ; '*'
        DB      17h
        DB      17h
        DB      17h
        DB      21h             ; '!'
        DB      36h             ; '6'
        DB      00h
        DB      09h
        DB      00h
        DB      19h
        DB      10h
        DB      19h
        DB      22h             ; '"'
        DB      19h
        DB      19h
        DB      19h
        DB      19h
        DB      35h             ; '5'
        DB      23h             ; '#'
        DB      0Ah
        DB      0Ah
        DB      2Bh             ; '+'
        DB      0Dh
        DB      00h
        DB      00h
        DB      23h             ; '#'
        DB      23h             ; '#'
        DB      36h             ; '6'
        DB      36h             ; '6'
        DB      17h
        DB      0Dh
        DB      33h             ; '3'
        DB      39h             ; '9'
        DB      0Dh
        DB      11h
        DB      39h             ; '9'
        DB      14h
        DB      14h
        DB      0Bh
        DB      14h
        DB      00h
        DB      00h
        DB      36h             ; '6'
        DB      25h             ; '%'
        DB      00h
        DB      00h
        DB      0Ah
        DB      0Ah
        DB      26h             ; '&'
        DB      27h             ; '''
        DB      00h
        DB      00h
        DB      00h
        DB      22h             ; '"'
        DB      36h             ; '6'
        DB      00h
        DB      17h
        DB      13h
        DB      14h
        DB      10h
        DB      26h             ; '&'
        DB      0Bh
        DB      00h
        DB      39h             ; '9'
        DB      39h             ; '9'
        DB      26h             ; '&'
        DB      27h             ; '''
        DB      0Dh
        DB      0Dh
        DB      2Ah             ; '*'
        DB      14h
        DB      00h
        DB      00h
        DB      00h
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      11h
        DB      15h
        DB      11h
        DB      11h
        DB      11h
        DB      11h
        DB      11h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      20h             ; ' '
        DB      11h
        DB      39h             ; '9'
        DB      17h
        DB      1Eh
        DB      15h
        DB      3Ch             ; '<'
        DB      39h             ; '9'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      14h
        DB      38h             ; '8'
        DB      11h
        DB      11h
        DB      33h             ; '3'
        DB      10h
        DB      31h             ; '1'
        DB      00h
        DB      00h
        DB      09h
        DB      00h
        DB      0Bh
        DB      00h
        DB      20h             ; ' '
        DB      10h
        DB      2Ah             ; '*'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      41h             ; 'A'
        DB      00h
        DB      00h
        DB      00h
        DB      0Dh
        DB      00h
        DB      3Bh             ; ';'
        DB      3Bh             ; ';'
        DB      00h
        DB      3Eh             ; '>'
        DB      10h
        DB      00h
        DB      12h
        DB      00h
        DB      00h
        DB      00h
        DB      10h
        DB      75h             ; 'u'
        DB      0Dh
        DB      0Ch
        DB      11h
        DB      37h             ; '7'
        DB      25h             ; '%'
        DB      28h             ; '('
        DB      4Ah             ; 'J'
        DB      0Fh
        DB      39h             ; '9'
        DB      30h             ; '0'
        DB      3Ch             ; '<'
        DB      4Ah             ; 'J'
        DB      46h             ; 'F'
        DB      35h             ; '5'
        DB      35h             ; '5'
        DB      2Ah             ; '*'
        DB      4Ah             ; 'J'
        DB      40h             ; '@'
        DB      6Eh             ; 'n'
        DB      1Bh
        DB      3Ch             ; '<'
        DB      48h             ; 'H'
        DB      2Eh             ; '.'
        DB      2Eh             ; '.'
        DB      3Bh             ; ';'
        DB      0Fh
        DB      3Bh             ; ';'
        DB      3Bh             ; ';'
        DB      35h             ; '5'
        DB      0Fh
        DB      10h
        DB      48h             ; 'H'
        DB      42h             ; 'B'
        DB      33h             ; '3'
        DB      42h             ; 'B'
        DB      36h             ; '6'
        DB      13h
        DB      14h
        DB      3Ah             ; ':'
        DB      46h             ; 'F'
        DB      36h             ; '6'
        DB      10h
        DB      48h             ; 'H'
        DB      48h             ; 'H'
        DB      16h
        DB      72h             ; 'r'
        DB      19h
        DB      34h             ; '4'
        DB      35h             ; '5'
        DB      03h
        DB      3Bh             ; ';'
        DB      36h             ; '6'
        DB      36h             ; '6'
        DB      1Ah
        DB      36h             ; '6'
        DB      48h             ; 'H'
        DB      33h             ; '3'
        DB      1Ch
        DB      10h
        DB      02h
        DB      36h             ; '6'
        DB      48h             ; 'H'
        DB      3Bh             ; ';'
        DB      37h             ; '7'
        DB      06h
        DB      06h
        DB      1Eh
        DB      37h             ; '7'
        DB      19h
        DB      21h             ; '!'
        DB      48h             ; 'H'
        DB      34h             ; '4'
        DB      22h             ; '"'
        DB      41h             ; 'A'
        DB      1Ah
        DB      23h             ; '#'
        DB      7Ah             ; 'z'
        DB      7Ah             ; 'z'
        DB      41h             ; 'A'
        DB      46h             ; 'F'
        DB      46h             ; 'F'
        DB      66h             ; 'f'
        DB      33h             ; '3'
        DB      29h             ; ')'
        DB      35h             ; '5'
        DB      3Ch             ; '<'
        DB      40h             ; '@'
        DB      46h             ; 'F'
        DB      37h             ; '7'
        DB      6Eh             ; 'n'
        DB      01h
        DB      36h             ; '6'
        DB      37h             ; '7'
        DB      1Ah
        DB      27h             ; '''
        DB      03h
        DB      03h
        DB      03h
        DB      37h             ; '7'
        DB      21h             ; '!'
        DB      36h             ; '6'
        DB      26h             ; '&'
        DB      55h             ; 'U'
        DB      55h             ; 'U'
        DB      33h             ; '3'
        DB      34h             ; '4'
        DB      31h             ; '1'
        DB      01h
        DB      32h             ; '2'
        DB      32h             ; '2'
        DB      31h             ; '1'
        DB      03h
        DB      03h
        DB      66h             ; 'f'
        DB      01h
        DB      76h             ; 'v'
        DB      0Ah
        DB      67h             ; 'g'
        DB      35h             ; '5'
        DB      67h             ; 'g'
        DB      67h             ; 'g'
        DB      3Ch             ; '<'
        DB      36h             ; '6'
        DB      6Eh             ; 'n'
        DB      6Eh             ; 'n'
        DB      6Eh             ; 'n'
        DB      6Eh             ; 'n'
        DB      6Eh             ; 'n'
        DB      6Eh             ; 'n'
        DB      6Eh             ; 'n'
        DB      6Eh             ; 'n'
        DB      6Eh             ; 'n'
        DB      35h             ; '5'
        DB      36h             ; '6'
        DB      48h             ; 'H'
        DB      48h             ; 'H'
        DB      0Bh
        DB      36h             ; '6'
        DB      6Eh             ; 'n'
        DB      18h
        DB      01h
        DB      36h             ; '6'
        DB      6Eh             ; 'n'
        DB      26h             ; '&'
        DB      6Eh             ; 'n'
        DB      76h             ; 'v'
        DB      36h             ; '6'
        DB      34h             ; '4'
        DB      01h
        DB      01h
        DB      70h             ; 'p'
        DB      3Ch             ; '<'
        DB      76h             ; 'v'
        DB      01h
        DB      76h             ; 'v'
        DB      77h             ; 'w'
        DB      68h             ; 'h'
        DB      48h             ; 'H'
        DB      33h             ; '3'
        DB      76h             ; 'v'
        DB      72h             ; 'r'
        DB      46h             ; 'F'
        DB      2Eh             ; '.'
        DB      66h             ; 'f'
        DB      72h             ; 'r'
        DB      19h
        DB      76h             ; 'v'
        DB      79h             ; 'y'
        DB      36h             ; '6'
        DB      3Eh             ; '>'
        DB      3Dh             ; '='
        DB      4Ah             ; 'J'
        DB      48h             ; 'H'
        DB      3Eh             ; '>'
        DB      3Fh             ; '?'
        DB      3Eh             ; '>'
        DB      2Dh             ; '-'
        DB      3Dh             ; '='
        DB      4Ch             ; 'L'
        DB      3Bh             ; ';'
        DB      3Eh             ; '>'
        DB      2Dh             ; '-'
        DB      04h
        DB      37h             ; '7'
        DB      37h             ; '7'
        DB      3Ch             ; '<'
        DB      3Ch             ; '<'
        DB      3Ch             ; '<'
        DB      3Ah             ; ':'
        DB      3Ch             ; '<'
        DB      48h             ; 'H'
        DB      00h
        DB      00h
        DB      00h
        DB      34h             ; '4'
        DB      3Dh             ; '='
        DB      34h             ; '4'
        DB      0Eh
        DB      00h
        DB      3Dh             ; '='
        DB      00h
        DB      76h             ; 'v'
        DB      00h
        DB      00h
        DB      00h
        DB      12h
        DB      00h
        DB      15h
        DB      76h             ; 'v'
        DB      37h             ; '7'
        DB      46h             ; 'F'
        DB      00h
        DB      76h             ; 'v'
        DB      76h             ; 'v'
        DB      00h
        DB      00h
        DB      00h
        DB      76h             ; 'v'
        DB      24h             ; '$'
        DB      3Bh             ; ';'
        DB      34h             ; '4'
        DB      40h             ; '@'
        DB      40h             ; '@'
        DB      00h
        DB      46h             ; 'F'
        DB      35h             ; '5'
        DB      00h
        DB      3Bh             ; ';'
        DB      00h
        DB      00h
        DB      46h             ; 'F'
        DB      76h             ; 'v'
        DB      3Bh             ; ';'
        DB      35h             ; '5'
        DB      00h
        DB      00h
        DB      3Ah             ; ':'
        DB      35h             ; '5'
        DB      00h
        DB      3Dh             ; '='
        DB      35h             ; '5'
        DB      76h             ; 'v'
        DB      00h
        DB      3Fh             ; '?'
        DB      00h
        DB      35h             ; '5'
        DB      6Eh             ; 'n'
        DB      27h             ; '''
        DB      00h
        DB      6Eh             ; 'n'
        DB      6Eh             ; 'n'
        DB      00h
        DB      00h
        DB      3Eh             ; '>'
        DB      35h             ; '5'
        DB      01h
        DB      00h
        DB      36h             ; '6'
        DB      3Ah             ; ':'
        DB      72h             ; 'r'
        DB      2Fh             ; '/'
        DB      46h             ; 'F'
        DB      35h             ; '5'
        DB      2Fh             ; '/'
        DB      2Fh             ; '/'
        DB      3Bh             ; ';'
        DB      00h
        DB      3Bh             ; ';'
        DB      35h             ; '5'
        DB      00h
        DB      46h             ; 'F'
        DB      00h
        DB      12h
        DB      12h
        DB      00h
        DB      76h             ; 'v'
        DB      35h             ; '5'
        DB      00h
        DB      3Ah             ; ':'
        DB      3Ah             ; ':'
        DB      35h             ; '5'
        DB      0Ch
        DB      0Dh
        DB      00h
        DB      00h
        DB      55h             ; 'U'
        DB      00h
        DB      00h
        DB      48h             ; 'H'
        DB      00h
        DB      00h
        DB      3Eh             ; '>'
        DB      46h             ; 'F'
        DB      69h             ; 'i'
        DB      69h             ; 'i'
        DB      69h             ; 'i'
        DB      6Ah             ; 'j'
        DB      6Dh             ; 'm'
        DB      6Dh             ; 'm'
        DB      6Dh             ; 'm'
        DB      69h             ; 'i'
        DB      6Ch             ; 'l'
        DB      37h             ; '7'
        DB      38h             ; '8'
        DB      0Ah
        DB      76h             ; 'v'
        DB      3Dh             ; '='
        DB      46h             ; 'F'
        DB      6Fh             ; 'o'
        DB      00h
        DB      00h
        DB      12h
        DB      69h             ; 'i'
        DB      00h
        DB      74h             ; 't'
        DB      55h             ; 'U'
        DB      46h             ; 'F'
        DB      76h             ; 'v'
        DB      78h             ; 'x'
        DB      2Fh             ; '/'
        DB      00h
        DB      7Ah             ; 'z'
        DB      47h             ; 'G'
        DB      00h
        DB      55h             ; 'U'
        DB      00h
        DB      49h             ; 'I'
        DB      00h
        DB      00h
        DB      34h             ; '4'
        DB      00h
        DB      7Bh             ; '{'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      7Dh             ; '}'
        DB      00h
        DB      4Ch             ; 'L'
        DB      00h
        DB      00h
        DB      3Bh             ; ';'
        DB      00h
        DB      3Ch             ; '<'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      34h             ; '4'
        DB      42h             ; 'B'
        DB      00h
        DB      3Dh             ; '='
        DB      35h             ; '5'
        DB      00h
        DB      3Ah             ; ':'
        DB      3Dh             ; '='
        DB      00h
        DB      73h             ; 's'
        DB      3Ch             ; '<'
        DB      4Ch             ; 'L'
        DB      00h
        DB      00h
        DB      00h
        DB      76h             ; 'v'
        DB      00h
        DB      76h             ; 'v'
        DB      35h             ; '5'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      39h             ; '9'
        DB      00h
        DB      3Dh             ; '='
        DB      00h
        DB      3Ah             ; ':'
        DB      40h             ; '@'
        DB      00h
        DB      00h
        DB      17h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      3Ah             ; ':'
        DB      00h
        DB      76h             ; 'v'
        DB      00h
        DB      00h
        DB      00h
        DB      40h             ; '@'
        DB      4Ch             ; 'L'
        DB      00h
        DB      35h             ; '5'
        DB      00h
        DB      00h
        DB      40h             ; '@'
        DB      1Dh
        DB      2Ch             ; ','
        DB      07h
        DB      00h
        DB      00h
        DB      35h             ; '5'
        DB      4Ch             ; 'L'
        DB      00h
        DB      00h
        DB      4Ch             ; 'L'
        DB      20h             ; ' '
        DB      00h
        DB      00h
        DB      00h
        DB      3Bh             ; ';'
        DB      6Fh             ; 'o'
        DB      3Ch             ; '<'
        DB      00h
        DB      71h             ; 'q'
        DB      71h             ; 'q'
        DB      00h
        DB      00h
        DB      37h             ; '7'
        DB      37h             ; '7'
        DB      6Eh             ; 'n'
        DB      00h
        DB      40h             ; '@'
        DB      1Fh
        DB      00h
        DB      00h
        DB      40h             ; '@'
        DB      08h
        DB      00h
        DB      00h
        DB      34h             ; '4'
        DB      00h
        DB      00h
        DB      05h
        DB      00h
        DB      40h             ; '@'
        DB      00h
        DB      3Eh             ; '>'
        DB      3Eh             ; '>'
        DB      00h
        DB      00h
        DB      3Ah             ; ':'
        DB      00h
        DB      3Dh             ; '='
        DB      3Dh             ; '='
        DB      3Ah             ; ':'
        DB      48h             ; 'H'
        DB      3Dh             ; '='
        DB      00h
        DB      00h
        DB      7Ch             ; '|'
        DB      00h
        DB      00h
        DB      76h             ; 'v'
        DB      00h
        DB      00h
        DB      76h             ; 'v'
        DB      40h             ; '@'
        DB      6Dh             ; 'm'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      46h             ; 'F'
        DB      4Ch             ; 'L'
        DB      09h
        DB      00h
        DB      40h             ; '@'
        DB      00h
        DB      00h
        DB      00h
        DB      38h             ; '8'
        DB      00h
        DB      00h
        DB      67h             ; 'g'
        DB      01h
        DB      40h             ; '@'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      00h
        DB      00h
        DB      01h
        DB      00h
        DB      48h             ; 'H'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      4Ch             ; 'L'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      40h             ; '@'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      6Bh             ; 'k'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      03h
        DB      00h
        DB      03h
        DB      37h             ; '7'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      40h             ; '@'
        DB      00h
        DB      3Bh             ; ';'
        DB      00h
        DB      14h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      3Ah             ; ':'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      45h             ; 'E'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      3Ch             ; '<'
        DB      00h
        DB      00h
        DB      69h             ; 'i'
        DB      69h             ; 'i'
        DB      00h
        DB      00h
        DB      00h
        DB      2Bh             ; '+'
        DB      6Bh             ; 'k'
        DB      00h
        DB      00h
        DB      3Ch             ; '<'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      3Ch             ; '<'
        DB      00h
        DB      00h
        DB      00h
        DB      3Ah             ; ':'
        DB      42h             ; 'B'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      3Bh             ; ';'
        DB      3Bh             ; ';'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      40h             ; '@'
        DB      00h
        DB      4Ch             ; 'L'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      40h             ; '@'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0A1h
        DB      00h
        DB      0A5h
        DB      01h
        DB      91h
        DB      01h
        DB      0Bh
        DB      02h
        DB      6Ch             ; 'l'
        DB      00h
        DB      0E4h
        DB      01h
        DB      8Dh
        DB      00h
        DB      96h
        DB      01h
        DB      0E2h
        DB      01h
        DB      68h             ; 'h'
        DB      00h
        DB      0A1h
        DB      00h
        DB      94h
        DB      00h
        DB      49h             ; 'I'
        DB      03h
        DB      1Eh
        DB      02h
        DB      0F8h
        DB      00h
        DB      0F8h
        DB      00h
        DB      1Ch
        DB      00h
        DB      20h             ; ' '
        DB      01h
        DB      0F8h
        DB      00h
        DB      0Dh
        DB      01h
        DB      1Ch
        DB      00h
        DB      40h             ; '@'
        DB      01h
        DB      0Ch
        DB      02h
        DB      0AAh
        DB      02h
        DB      52h             ; 'R'
        DB      00h
        DB      8Eh
        DB      00h
        DB      0CEh
        DB      01h
        DB      8Eh
        DB      00h
        DB      0CDh
        DB      01h
        DB      0CDh
        DB      01h
        DB      0E2h
        DB      01h
        DB      0E2h
        DB      01h
        DB      0E2h
        DB      01h
        DB      00h
        DB      00h
        DB      6Ch             ; 'l'
        DB      01h
        DB      00h
        DB      00h
        DB      45h             ; 'E'
        DB      02h
        DB      36h             ; '6'
        DB      02h
        DB      6Dh             ; 'm'
        DB      02h
        DB      0Bh
        DB      02h
        DB      6Eh             ; 'n'
        DB      02h
        DB      94h
        DB      01h
        DB      18h
        DB      00h
        DB      18h
        DB      00h
        DB      6Dh             ; 'm'
        DB      02h
        DB      6Ah             ; 'j'
        DB      01h
        DB      00h
        DB      00h
        DB      80h
        DB      01h
        DB      0FAh
        DB      02h
        DB      0F9h
        DB      02h
        DB      99h
        DB      03h
        DB      7Ah             ; 'z'
        DB      00h
        DB      80h
        DB      01h
        DB      0A8h
        DB      01h
        DB      0A8h
        DB      01h
        DB      0A8h
        DB      01h
        DB      0D3h
        DB      02h
        DB      6Ch             ; 'l'
        DB      01h
        DB      09h
        DB      02h
        DB      7Ah             ; 'z'
        DB      00h
        DB      3Eh             ; '>'
        DB      00h
        DB      28h             ; '('
        DB      00h
        DB      0F1h
        DB      00h
        DB      0BBh
        DB      01h
        DB      64h             ; 'd'
        DB      00h
        DB      68h             ; 'h'
        DB      00h
        DB      68h             ; 'h'
        DB      00h
        DB      0DDh
        DB      00h
        DB      42h             ; 'B'
        DB      01h
        DB      00h
        DB      00h
        DB      80h
        DB      01h
        DB      0D3h
        DB      02h
        DB      0D2h
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0FAh
        DB      02h
        DB      0F9h
        DB      02h
        DB      44h             ; 'D'
        DB      00h
        DB      44h             ; 'D'
        DB      00h
        DB      00h
        DB      00h
        DB      91h
        DB      01h
        DB      0A5h
        DB      01h
        DB      6Ch             ; 'l'
        DB      01h
        DB      0AAh
        DB      02h
        DB      0F6h
        DB      01h
        DB      09h
        DB      02h
        DB      44h             ; 'D'
        DB      00h
        DB      56h             ; 'V'
        DB      01h
        DB      0BEh
        DB      02h
        DB      44h             ; 'D'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      52h             ; 'R'
        DB      00h
        DB      66h             ; 'f'
        DB      00h
        DB      0F6h
        DB      01h
        DB      1Eh
        DB      02h
        DB      0F1h
        DB      00h
        DB      7Ah             ; 'z'
        DB      00h
        DB      0CFh
        DB      01h
        DB      42h             ; 'B'
        DB      01h
        DB      0Ch
        DB      02h
        DB      0Ch
        DB      02h
        DB      0E2h
        DB      00h
        DB      0AFh
        DB      03h
        DB      0DDh
        DB      00h
        DB      0B7h
        DB      00h
        DB      8Eh
        DB      00h
        DB      0CBh
        DB      00h
        DB      0CBh
        DB      00h
        DB      0CBh
        DB      00h
        DB      0CBh
        DB      00h
        DB      0CBh
        DB      00h
        DB      91h
        DB      01h
        DB      0A5h
        DB      01h
        DB      0Fh
        DB      02h
        DB      00h
        DB      00h
        DB      0DEh
        DB      00h
        DB      0B7h
        DB      00h
        DB      00h
        DB      00h
        DB      09h
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      44h             ; 'D'
        DB      00h
        DB      0E0h
        DB      00h
        DB      0Ch
        DB      02h
        DB      0E0h
        DB      00h
        DB      80h
        DB      01h
        DB      0D0h
        DB      01h
        DB      08h
        DB      01h
        DB      58h             ; 'X'
        DB      01h
        DB      30h             ; '0'
        DB      01h
        DB      0A8h
        DB      01h
        DB      0A4h
        DB      00h
        DB      19h
        DB      01h
        DB      56h             ; 'V'
        DB      01h
        DB      0CBh
        DB      00h
        DB      0B7h
        DB      00h
        DB      3Eh             ; '>'
        DB      00h
        DB      12h
        DB      04h
        DB      00h
        DB      00h
        DB      31h             ; '1'
        DB      02h
        DB      00h
        DB      00h
        DB      45h             ; 'E'
        DB      02h
        DB      18h
        DB      00h
        DB      0E2h
        DB      00h
        DB      94h
        DB      01h
        DB      00h
        DB      00h
        DB      54h             ; 'T'
        DB      00h
        DB      0CEh
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      44h             ; 'D'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0F1h
        DB      00h
        DB      02h
        DB      00h
        DB      02h
        DB      00h
        DB      62h             ; 'b'
        DB      04h
        DB      00h
        DB      00h
        DB      0DBh
        DB      04h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      48h             ; 'H'
        DB      02h
        DB      82h
        DB      01h
        DB      9Bh
        DB      02h
        DB      0A4h
        DB      01h
        DB      08h
        DB      02h
        DB      0F8h
        DB      02h
        DB      00h
        DB      00h
        DB      8Ch
        DB      00h
        DB      0AAh
        DB      01h
        DB      98h
        DB      00h
        DB      34h             ; '4'
        DB      01h
        DB      0F6h
        DB      00h
        DB      8Ch
        DB      00h
        DB      0AAh
        DB      01h
        DB      8Fh
        DB      00h
        DB      82h
        DB      02h
        DB      1Eh
        DB      02h
        DB      31h             ; '1'
        DB      00h
        DB      04h
        DB      01h
        DB      0F0h
        DB      00h
        DB      04h
        DB      01h
        DB      30h             ; '0'
        DB      00h
        DB      48h             ; 'H'
        DB      01h
        DB      47h             ; 'G'
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0A5h
        DB      01h
        DB      92h
        DB      00h
        DB      91h
        DB      01h
        DB      0CCh
        DB      01h
        DB      0CCh
        DB      01h
        DB      92h
        DB      00h
        DB      8Dh
        DB      00h
        DB      8Dh
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      58h             ; 'X'
        DB      01h
        DB      00h
        DB      00h
        DB      31h             ; '1'
        DB      02h
        DB      54h             ; 'T'
        DB      01h
        DB      31h             ; '1'
        DB      02h
        DB      0BEh
        DB      02h
        DB      26h             ; '&'
        DB      03h
        DB      21h             ; '!'
        DB      03h
        DB      6Ch             ; 'l'
        DB      02h
        DB      31h             ; '1'
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0F8h
        DB      02h
        DB      0F8h
        DB      02h
        DB      98h
        DB      03h
        DB      05h
        DB      01h
        DB      0A4h
        DB      01h
        DB      7Ch             ; '|'
        DB      01h
        DB      0F6h
        DB      01h
        DB      0F9h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0F6h
        DB      01h
        DB      0Ah
        DB      01h
        DB      00h
        DB      00h
        DB      66h             ; 'f'
        DB      00h
        DB      0F0h
        DB      00h
        DB      0B1h
        DB      04h
        DB      66h             ; 'f'
        DB      00h
        DB      42h             ; 'B'
        DB      01h
        DB      42h             ; 'B'
        DB      01h
        DB      3Ch             ; '<'
        DB      00h
        DB      19h
        DB      01h
        DB      00h
        DB      00h
        DB      0D1h
        DB      02h
        DB      00h
        DB      00h
        DB      0D0h
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0F6h
        DB      01h
        DB      49h             ; 'I'
        DB      02h
        DB      0FDh
        DB      02h
        DB      3Ch             ; '<'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      5Ch             ; '\'
        DB      03h
        DB      1Eh
        DB      02h
        DB      3Ch             ; '<'
        DB      00h
        DB      00h
        DB      00h
        DB      7Ch             ; '|'
        DB      01h
        DB      0F8h
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      3Ch             ; '<'
        DB      00h
        DB      0DDh
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0F0h
        DB      00h
        DB      00h
        DB      00h
        DB      0CCh
        DB      01h
        DB      44h             ; 'D'
        DB      00h
        DB      0Ah
        DB      00h
        DB      0Bh
        DB      00h
        DB      00h
        DB      00h
        DB      0DDh
        DB      00h
        DB      0Fh
        DB      02h
        DB      00h
        DB      00h
        DB      8Ch
        DB      00h
        DB      0A9h
        DB      00h
        DB      0E4h
        DB      00h
        DB      0D0h
        DB      00h
        DB      0BCh
        DB      00h
        DB      0A8h
        DB      00h
        DB      90h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0E0h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      3Ch             ; '<'
        DB      00h
        DB      30h             ; '0'
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      42h             ; 'B'
        DB      01h
        DB      78h             ; 'x'
        DB      00h
        DB      0C8h
        DB      00h
        DB      0B4h
        DB      00h
        DB      00h
        DB      00h
        DB      0E0h
        DB      01h
        DB      00h
        DB      00h
        DB      6Dh             ; 'm'
        DB      01h
        DB      00h
        DB      00h
        DB      5Bh             ; '['
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      64h             ; 'd'
        DB      00h
        DB      0CCh
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      3Ch             ; '<'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      6Ch             ; 'l'
        DB      01h
        DB      60h             ; '`'
        DB      04h
        DB      00h
        DB      00h
        DB      60h             ; '`'
        DB      04h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      58h             ; 'X'
        DB      02h
        DB      0A0h
        DB      00h
        DB      00h
        DB      00h
        DB      90h
        DB      01h
        DB      04h
        DB      01h
        DB      34h             ; '4'
        DB      03h
        DB      00h
        DB      00h
        DB      14h
        DB      00h
        DB      90h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0A0h
        DB      00h
        DB      0ACh
        DB      03h
        DB      96h
        DB      01h
        DB      00h
        DB      00h
        DB      0D0h
        DB      02h
        DB      10h
        DB      04h
        DB      14h
        DB      00h
        DB      18h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      14h
        DB      00h
        DB      0B0h
        DB      04h
        DB      44h             ; 'D'
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0A4h
        DB      01h
        DB      0E2h
        DB      01h
        DB      90h
        DB      01h
        DB      0F6h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0Ah
        DB      01h
        DB      05h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0CCh
        DB      01h
        DB      00h
        DB      00h
        DB      6Ch             ; 'l'
        DB      02h
        DB      00h
        DB      00h
        DB      6Ch             ; 'l'
        DB      02h
        DB      7Ch             ; '|'
        DB      01h
        DB      00h
        DB      00h
        DB      20h             ; ' '
        DB      03h
        DB      20h             ; ' '
        DB      03h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0F9h
        DB      01h
        DB      46h             ; 'F'
        DB      02h
        DB      00h
        DB      00h
        DB      04h
        DB      01h
        DB      0D6h
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0B8h
        DB      01h
        DB      0A8h
        DB      02h
        DB      00h
        DB      00h
        DB      08h
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      04h
        DB      01h
        DB      0B8h
        DB      01h
        DB      24h             ; '$'
        DB      01h
        DB      1Eh
        DB      01h
        DB      1Eh
        DB      01h
        DB      0DCh
        DB      00h
        DB      40h             ; '@'
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0A8h
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      34h             ; '4'
        DB      03h
        DB      3Ch             ; '<'
        DB      00h
        DB      1Eh
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      68h             ; 'h'
        DB      01h
        DB      0E0h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      64h             ; 'd'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      64h             ; 'd'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      04h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      40h             ; '@'
        DB      01h
        DB      00h
        DB      00h
        DB      0C8h
        DB      00h
        DB      00h
        DB      00h
        DB      0DCh
        DB      00h
        DB      0DCh
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0C0h
        DB      03h
        DB      00h
        DB      00h
        DB      0DCh
        DB      00h
        DB      0C8h
        DB      00h
        DB      0D4h
        DB      03h
        DB      0A4h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      08h
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0Ch
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      54h             ; 'T'
        DB      01h
        DB      00h
        DB      00h
        DB      0B4h
        DB      00h
        DB      0C8h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      54h             ; 'T'
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0F0h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0C8h
        DB      00h
        DB      00h
        DB      00h
        DB      92h
        DB      00h
        DB      5Dh             ; ']'
        DB      01h
        DB      0A4h
        DB      01h
        DB      00h
        DB      00h
        DB      0F6h
        DB      00h
        DB      4Ah             ; 'J'
        DB      03h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      4Ch             ; 'L'
        DB      04h
        DB      0F4h
        DB      01h
        DB      90h
        DB      01h
        DB      00h
        DB      00h
        DB      80h
        DB      02h
        DB      1Ch
        DB      02h
        DB      28h             ; '('
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      28h             ; '('
        DB      00h
        DB      0B4h
        DB      00h
        DB      0C4h
        DB      04h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      8Ch
        DB      00h
        DB      00h
        DB      00h
        DB      8Ch
        DB      00h
        DB      0Ch
        DB      03h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      04h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0F0h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      6Ch             ; 'l'
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      14h
        DB      00h
        DB      00h
        DB      00h
        DB      0F0h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      84h
        DB      03h
        DB      00h
        DB      00h
        DB      0E0h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      6Fh             ; 'o'
        DB      01h
        DB      0B0h
        DB      04h
        DB      50h             ; 'P'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      54h             ; 'T'
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      84h
        DB      03h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0F8h
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0F4h
        DB      01h
        DB      70h             ; 'p'
        DB      03h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      50h             ; 'P'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      50h             ; 'P'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      54h             ; 'T'
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0F4h
        DB      01h
        DB      0F4h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0A0h
        DB      00h
        DB      00h
        DB      00h
        DB      0C0h
        DB      03h
        DB      0D4h
        DB      03h
        DB      0B4h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      04h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0DCh
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      40h             ; '@'
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      9Bh
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      04h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      64h             ; 'd'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      92h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      92h
        DB      00h
        DB      00h
        DB      00h
        DB      0BCh
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0F4h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      08h
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0AAh
        DB      02h
        DB      00h
        DB      00h
        DB      18h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0DDh
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0AAh
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      1Ch
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0FAh
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      19h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      3Ch             ; '<'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      8Ch
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0C8h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0Fh
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      08h
        DB      1Ah
        DB      09h
        DB      1Ah
        DB      16h
        DB      1Ah
        DB      31h             ; '1'
        DB      1Ah
        DB      50h             ; 'P'
        DB      1Ah
        DB      6Dh             ; 'm'
        DB      1Ah
        DB      90h
        DB      1Ah
        DB      0A7h
        DB      1Ah
        DB      0B4h
        DB      1Ah
        DB      0C7h
        DB      1Ah
        DB      0D6h
        DB      1Ah
        DB      0F2h
        DB      1Ah
        DB      0F9h
        DB      1Ah
        DB      06h
        DB      1Bh
        DB      13h
        DB      1Bh
        DB      20h             ; ' '
        DB      1Bh
        DB      2Dh             ; '-'
        DB      1Bh
        DB      3Ah             ; ':'
        DB      1Bh
        DB      47h             ; 'G'
        DB      1Bh
        DB      0DDh
        DB      1Bh
        DB      24h             ; '$'
        DB      1Ch
        DB      32h             ; '2'
        DB      1Ch
        DB      7Ch             ; '|'
        DB      1Ch
        DB      88h
        DB      1Ch
        DB      95h
        DB      1Ch
        DB      0FCh
        DB      1Ch
        DB      09h
        DB      1Dh
        DB      18h
        DB      1Dh
        DB      48h             ; 'H'
        DB      1Dh
        DB      87h
        DB      1Dh
        DB      0ADh
        DB      1Dh
        DB      08h
        DB      1Eh
        DB      2Ah             ; '*'
        DB      1Eh
        DB      46h             ; 'F'
        DB      1Eh
        DB      00h
        DB      00h
        DB      17h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      1Fh
        DB      00h
        DB      00h
        DB      00h
        DB      07h
        DB      00h
        DB      1Ah
        DB      00h
        DB      0Bh
        DB      00h
        DB      0Dh
        DB      00h
        DB      00h
        DB      00h
        DB      11h
        DB      00h
        DB      0Ch
        DB      00h
        DB      00h
        DB      00h
        DB      11h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0Bh
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0Ah
        DB      00h
        DB      00h
        DB      00h
        DB      08h
        DB      00h
        DB      20h             ; ' '
        DB      00h
        DB      20h             ; ' '
        DB      00h
        DB      07h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      09h
        DB      00h
        DB      1Fh
        DB      00h
        DB      00h
        DB      00h
        DB      1Dh
        DB      00h
        DB      0Bh
        DB      00h
        DB      0Fh
        DB      00h
        DB      00h
        DB      00h
        DB      0Ch
        DB      00h
        DB      00h
        DB      00h
        DB      11h
        DB      00h
        DB      0Ch
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      07h
        DB      00h
        DB      21h             ; '!'
        DB      00h
        DB      18h
        DB      00h
        DB      0Ah
        DB      00h
        DB      1Dh
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      17h
        DB      00h
        DB      0Fh
        DB      00h
        DB      00h
        DB      00h
        DB      0Dh
        DB      00h
        DB      0Dh
        DB      00h
        DB      00h
        DB      00h
        DB      0Ch
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0Ah
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      07h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      20h             ; ' '
        DB      00h
        DB      0Bh
        DB      00h
        DB      01h
        DB      00h
        DB      19h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      1Bh
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      17h
        DB      00h
        DB      0Bh
        DB      00h
        DB      00h
        DB      00h
        DB      0Eh
        DB      00h
        DB      10h
        DB      00h
        DB      0Ch
        DB      00h
        DB      00h
        DB      00h
        DB      0Fh
        DB      00h
        DB      00h
        DB      00h
        DB      14h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      15h
        DB      00h
        DB      0Bh
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      20h             ; ' '
        DB      00h
        DB      18h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      00h
        DB      03h
        DB      00h
        DB      04h
        DB      00h
        DB      05h
        DB      00h
        DB      06h
        DB      00h
        DB      00h
        DB      00h
        DB      14h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0Ch
        DB      00h
        DB      10h
        DB      00h
        DB      0Dh
        DB      00h
        DB      0Eh
        DB      00h
        DB      0Eh
        DB      00h
        DB      11h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      1Dh
        DB      00h
        DB      00h
        DB      00h
        DB      20h             ; ' '
        DB      00h
        DB      1Ch
        DB      00h
        DB      18h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      00h
        DB      04h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      07h
        DB      00h
        DB      0Ch
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0Dh
        DB      00h
        DB      00h
        DB      00h
        DB      11h
        DB      00h
        DB      00h
        DB      00h
        DB      11h
        DB      00h
        DB      12h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      09h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0Bh
        DB      00h
        DB      00h
        DB      00h
        DB      18h
        DB      00h
        DB      00h
        DB      00h
        DB      20h             ; ' '
        DB      00h
        DB      18h
        DB      00h
        DB      8Bh
        DB      1Eh
        DB      8Ch
        DB      1Eh
        DB      9Ch
        DB      1Eh
        DB      0ABh
        DB      1Eh
        DB      0C9h
        DB      1Eh
        DB      0F8h
        DB      1Eh
        DB      06h
        DB      1Fh
        DB      19h
        DB      1Fh
        DB      5Ah             ; 'Z'
        DB      1Fh
        DB      62h             ; 'b'
        DB      1Fh
        DB      6Eh             ; 'n'
        DB      1Fh
        DB      9Ah
        DB      1Fh
        DB      0AEh
        DB      1Fh
        DB      0D3h
        DB      1Fh
        DB      0F7h
        DB      1Fh
        DB      1Dh
        DB      20h             ; ' '
        DB      2Bh             ; '+'
        DB      20h             ; ' '
        DB      4Ch             ; 'L'
        DB      20h             ; ' '
        DB      74h             ; 't'
        DB      20h             ; ' '
        DB      9Ah
        DB      20h             ; ' '
        DB      0B3h
        DB      20h             ; ' '
        DB      0C7h
        DB      20h             ; ' '
        DB      0D4h
        DB      20h             ; ' '
        DB      02h
        DB      21h             ; '!'
        DB      28h             ; '('
        DB      21h             ; '!'
        DB      3Ah             ; ':'
        DB      21h             ; '!'
        DB      3Fh             ; '?'
        DB      21h             ; '!'
        DB      51h             ; 'Q'
        DB      21h             ; '!'
        DB      82h
        DB      21h             ; '!'
        DB      0AAh
        DB      21h             ; '!'
        DB      0C3h
        DB      21h             ; '!'
        DB      0EEh
        DB      21h             ; '!'
        DB      0Dh
        DB      22h             ; '"'
        DB      18h
        DB      22h             ; '"'
        DB      36h             ; '6'
        DB      22h             ; '"'
        DB      4Ch             ; 'L'
        DB      22h             ; '"'
        DB      81h
        DB      22h             ; '"'
        DB      0B1h
        DB      22h             ; '"'
        DB      0CBh
        DB      22h             ; '"'
        DB      0F0h
        DB      22h             ; '"'
        DB      16h
        DB      23h             ; '#'
        DB      35h             ; '5'
        DB      23h             ; '#'
        DB      65h             ; 'e'
        DB      23h             ; '#'
        DB      0A0h
        DB      23h             ; '#'
        DB      0EDh
        DB      23h             ; '#'
        DB      04h
        DB      24h             ; '$'
        DB      1Eh
        DB      24h             ; '$'
        DB      5Ah             ; 'Z'
        DB      24h             ; '$'
        DB      79h             ; 'y'
        DB      24h             ; '$'
        DB      91h
        DB      24h             ; '$'
        DB      0CAh
        DB      24h             ; '$'
        DB      2Ah             ; '*'
        DB      25h             ; '%'
        DB      3Bh             ; ';'
        DB      25h             ; '%'
        DB      45h             ; 'E'
        DB      25h             ; '%'
        DB      53h             ; 'S'
        DB      25h             ; '%'
        DB      5Dh             ; ']'
        DB      25h             ; '%'
        DB      0C0h
        DB      25h             ; '%'
        DB      0EAh
        DB      25h             ; '%'
        DB      0Dh
        DB      26h             ; '&'
        DB      2Ah             ; '*'
        DB      26h             ; '&'
        DB      4Fh             ; 'O'
        DB      26h             ; '&'
        DB      64h             ; 'd'
        DB      26h             ; '&'
        DB      7Ah             ; 'z'
        DB      26h             ; '&'
        DB      9Ah
        DB      26h             ; '&'
        DB      0B6h
        DB      26h             ; '&'
        DB      0CFh
        DB      26h             ; '&'
        DB      6Bh             ; 'k'
        DB      27h             ; '''
        DB      77h             ; 'w'
        DB      27h             ; '''
        DB      9Bh
        DB      27h             ; '''
        DB      9Eh
        DB      27h             ; '''
        DB      0B5h
        DB      27h             ; '''
        DB      0D7h
        DB      27h             ; '''
        DB      0DDh
        DB      27h             ; '''
        DB      0EDh
        DB      27h             ; '''
        DB      90h
        DB      28h             ; '('
        DB      0A1h
        DB      28h             ; '('
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      7Eh             ; '~'
        DB      0E6h
        DB      07h
        DB      0C6h
        DB      0Ah
        DB      16h
        DB      0Eh
        DB      5Fh             ; '_'
        DB      1Ah
        DB      0C9h
        DB      4Bh             ; 'K'
        DB      4Ch             ; 'L'
        DB      4Dh             ; 'M'
        DB      4Eh             ; 'N'
        DB      4Fh             ; 'O'
        DB      50h             ; 'P'
        DB      2Ah             ; '*'
        DB      4Ah             ; 'J'
        DB      3Ah             ; ':'
        DB      0Fh
        DB      04h
        DB      0C6h
        DB      17h
        DB      6Fh             ; 'o'
        DB      26h             ; '&'
        DB      04h
        DB      0E5h
        DB      7Eh             ; '~'
        DB      0E6h
        DB      0C0h
        DB      28h             ; '('
        DB      20h             ; ' '
        DB      07h
        DB      07h
        DB      0C6h
        DB      34h             ; '4'
        DB      0CDh
        DB      66h             ; 'f'
        DB      0Eh
        DB      0E1h
        DB      0CDh
        DB      00h
        DB      0Eh
        DB      0E5h
        DB      0CDh
        DB      0C1h
        DB      06h
        DB      3Eh             ; '>'
        DB      2Ch             ; ','
        DB      0CDh
        DB      20h             ; ' '
        DB      04h
        DB      0E1h
        DB      7Eh             ; '~'
        DB      0E6h
        DB      38h             ; '8'
        DB      0Fh
        DB      0Fh
        DB      0Fh
        DB      0C6h
        DB      30h             ; '0'
        DB      0C3h
        DB      20h             ; ' '
        DB      04h
        DB      7Eh             ; '~'
        DB      0E6h
        DB      38h             ; '8'
        DB      0Fh
        DB      0Fh
        DB      0Fh
        DB      0FEh
        DB      06h
        DB      0E1h
        DB      0C8h
        DB      0E5h
        DB      0C6h
        DB      40h             ; '@'
        DB      0CDh
        DB      66h             ; 'f'
        DB      0Eh
        DB      0E1h
        DB      0CDh
        DB      00h
        DB      0Eh
        DB      0C3h
        DB      0C1h
        DB      06h
        DB      00h
        DB      3Eh             ; '>'
        DB      02h
        DB      32h             ; '2'
        DB      0Fh
        DB      04h
        DB      0CDh
        DB      0E7h
        DB      06h
        DB      0CDh
        DB      12h
        DB      0Eh
        DB      0C3h
        DB      8Ch
        DB      07h
        DB      0CDh
        DB      0C1h
        DB      06h
        DB      0C3h
        DB      0C8h
        DB      05h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      21h             ; '!'
        DB      49h             ; 'I'
        DB      58h             ; 'X'
        DB      18h
        DB      03h
        DB      21h             ; '!'
        DB      49h             ; 'I'
        DB      59h             ; 'Y'
        DB      22h             ; '"'
        DB      98h
        DB      0Ch
        DB      22h             ; '"'
        DB      0A9h
        DB      0Ch
        DB      3Ah             ; ':'
        DB      19h
        DB      04h
        DB      26h             ; '&'
        DB      02h
        DB      0CBh
        DB      27h             ; '''
        DB      0CBh
        DB      14h
        DB      0CBh
        DB      27h             ; '''
        DB      0CBh
        DB      14h
        DB      6Fh             ; 'o'
        DB      11h
        DB      10h
        DB      04h
        DB      01h
        DB      00h
        DB      04h
        DB      7Eh             ; '~'
        DB      12h
        DB      23h             ; '#'
        DB      13h
        DB      0FEh
        DB      2Ah             ; '*'
        DB      20h             ; ' '
        DB      02h
        DB      0Eh
        DB      02h
        DB      0FEh
        DB      26h             ; '&'
        DB      20h             ; ' '
        DB      02h
        DB      0Eh
        DB      01h
        DB      10h
        DB      0EEh
        DB      0CDh
        DB      13h
        DB      07h
        DB      79h             ; 'y'
        DB      0B7h
        DB      28h             ; '('
        DB      12h
        DB      3Ah             ; ':'
        DB      0Fh
        DB      04h
        DB      81h
        DB      32h             ; '2'
        DB      0Fh
        DB      04h
        DB      3Ah             ; ':'
        DB      19h
        DB      04h
        DB      0FEh
        DB      0CBh
        DB      0CAh
        DB      5Dh             ; ']'
        DB      0Eh
        DB      0C3h
        DB      69h             ; 'i'
        DB      07h
        DB      3Eh             ; '>'
        DB      02h
        DB      32h             ; '2'
        DB      0Fh
        DB      04h
        DB      0CDh
        DB      0E7h
        DB      06h
        DB      0C3h
        DB      8Ch
        DB      07h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      43h             ; 'C'
        DB      6Ch             ; 'l'
        DB      61h             ; 'a'
        DB      75h             ; 'u'
        DB      64h             ; 'd'
        DB      65h             ; 'e'
        DB      27h             ; '''
        DB      73h             ; 's'
        DB      20h             ; ' '
        DB      44h             ; 'D'
        DB      69h             ; 'i'
        DB      73h             ; 's'
        DB      2Eh             ; '.'
        DB      56h             ; 'V'
        DB      20h             ; ' '
        DB      31h             ; '1'
        DB      30h             ; '0'
        DB      00h
        DB      41h             ; 'A'
        DB      63h             ; 'c'
        DB      74h             ; 't'
        DB      69h             ; 'i'
        DB      6Fh             ; 'o'
        DB      6Eh             ; 'n'
        DB      20h             ; ' '
        DB      3Fh             ; '?'
        DB      00h
        DB      48h             ; 'H'
        DB      61h             ; 'a'
        DB      72h             ; 'r'
        DB      64h             ; 'd'
        DB      00h
        DB      53h             ; 'S'
        DB      6Fh             ; 'o'
        DB      66h             ; 'f'
        DB      74h             ; 't'
        DB      00h
        DB      0C6h
        DB      30h             ; '0'
        DB      77h             ; 'w'
        DB      0F1h
        DB      0CDh
        DB      1Dh
        DB      07h
        DB      0C3h
        DB      69h             ; 'i'
        DB      07h
        DB      00h
