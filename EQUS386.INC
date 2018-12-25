.;---------------------------------------------------------------------------;
; M.F.Kaplon  Begun:Sat  05-30-1992   Revised:Sat  07-11-1992
; Title : equates.inc
; Equates for use by 386_dos.mac and 386 types ASM programs
;---------------------------------------------------------------------------;

;equates related to message structure
HWND_DESKTOP   equ   1               ;needed for  WinErrorMessage macro
hwnd           equ   quemsg.qmsg_hwnd
msg            equ   quemsg.qmsg_msg
mp1            equ   quemsg.qmsg_mp1
mp2            equ   quemsg.qmsg_mp2
msgBoxErrStyle equ   (MB_ERROR OR MB_CANCEL)


VK_ESC         equ   0fh       ;Virtual Key Defines
VK_F1          equ   20h
VK_F2          equ   21h
VK_F3          equ   22h
VK_F4          equ   23h
VK_F5          equ   24h
VK_F6          equ   25h
VK_F7          equ   26h
VK_F8          equ   27h
VK_F9          equ   28h
VK_F10         equ   29h
VK_F11         equ   2Ah
VK_F12         equ   2Bh


;---------------- I/O DOS Calls Only---------------
stdin          equ   0
stdout         equ   1
stderr         equ   2

;---------------- Useful ---------------
cr             equ   0dh
lf             equ   0ah
nl             equ   0dh,0ah   ;cr+lf
BEL            equ   07h
NULL           equ   0000h


;------------ Equates for Shift State for KbdDataIn structure
RightShiftDown   equ  0000000000000001b
LeftShiftDown    equ  0000000000000010b
EitherCtrlDown   equ  0000000000000100b
EitherAltlDown   equ  0000000000001000b
ScrollLockOn     equ  0000000000010000b
NumLockOn        equ  0000000000100000b
CapsLockOn       equ  0000000001000000b
InsertOn         equ  0000000010000000b
LeftCtrlDown     equ  0000000100000000b
LeftAltDown      equ  0000001000000000b
RightCtrlDown    equ  0000010000000000b
RightAltDown     equ  0000100000000000b
ScrollLockDown   equ  0001000000000000b
NumLockDown      equ  0010000000000000b
CapsLockDown     equ  0100000000000000b
SysReqDown       equ  1000000000000000b

;------------ Equates for Status Word of KbnDataIn structure
ShiftRetWOChar   equ  0000000000000001b
OSConvReqstd     equ  0000000000100000b
CharReady        equ  0000000001000000b
InterimChar      equ  0000000010000000b

;------------- Keyboard Definitions ----------
;------- Define ASCII characters
;------ Actual Definitions Used Composed of WORd Value
;------ with Scan Code as High Byte and CharCode as Low Byte
;
;------------ ASCII kEYS ---------
;Alt-abc on Key Pad Returns CharCode = abc and Scan Code = 0
;Thus AX = ScanCode:CharCode = 00CharCodeH = CharCode
K_C_2            equ  00300H ;CharCode =    0  00H   ScanCode =   03  03H
K_C_A            equ  01E01H ;CharCode =    1  01H   ScanCode =   30  1eH
K_C_B            equ  03002H ;CharCode =    2  02H   ScanCode =   48  30H
K_C_C            equ  02E03H ;CharCode =    3  03H   ScanCode =   46  2eH
K_C_D            equ  02004H ;CharCode =    4  04H   ScanCode =   32  20H
K_C_E            equ  01205H ;CharCode =    5  05H   ScanCode =   18  12H
K_C_F            equ  02106H ;CharCode =    6  06H   ScanCode =   33  21H
K_C_G            equ  02207H ;CharCode =    7  07H   ScanCode =   34  22H
K_C_H            equ  02308H ;CharCode =    8  08H   ScanCode =   35  23H
K_BS             equ  00e08H ;CharCode =    8  08H   ScanCode =   14  0eH
K_C_I            equ  01709H ;CharCode =    9  09H   ScanCode =   23  17H
K_TAB            equ  00F09H ;CharCode =    9  09H   ScanCode =   15  0fH
K_C_J            equ  0240AH ;CharCode =   10  0aH   ScanCode =   36  24H
K_C_K            equ  0250BH ;CharCode =   11  0bH   ScanCode =   37  25H
K_C_L            equ  0260CH ;CharCode =   12  0cH   ScanCode =   38  26H
K_ENTER          equ  01C0DH ;CharCode =   13  0dH   ScanCode =   28  1cH
K_C_M            equ  0320DH ;CharCode =   13  0dH   ScanCode =   50  32H
K_C_N            equ  0310EH ;CharCode =   14  0eH   ScanCode =   49  31H
K_C_O            equ  0180FH ;CharCode =   15  0fH   ScanCode =   24  18H
K_C_P            equ  01910H ;CharCode =   16  10H   ScanCode =   25  19H
K_C_Q            equ  01011H ;CharCode =   17  11H   ScanCode =   16  10H
K_C_R            equ  01318H ;CharCode =   18  12H   ScanCode =   19  13H
K_C_S            equ  01F13H ;CharCode =   19  13H   ScanCode =   31  1fH
K_C_T            equ  01414H ;CharCode =   20  14H   ScanCode =   20  14H
K_C_U            equ  01615H ;CharCode =   21  15H   ScanCode =   22  16H
K_C_V            equ  02F16H ;CharCode =   22  16H   ScanCode =   47  2fH
K_C_W            equ  01117H ;CharCode =   23  17H   ScanCode =   17  11H
K_C_X            equ  02D18H ;CharCode =   24  18H   ScanCode =   45  2dH
K_C_Y            equ  01519H ;CharCode =   25  19H   ScanCode =   21  15H
K_C_Z            equ  02C1AH ;CharCode =   26  1aH   ScanCode =   44  2cH
K_ESC            equ  0011BH ;CharCode =   27  1bH   ScanCode =    1  01H
K_C_OPENBRKT     equ  0261BH ;CharCode =   27  1bH   ScanCode =   26  1aH
K_C_BACKSLASH    equ  0261CH ;CharCode =   28  1dH   ScanCode =   43  26H
K_C_CLOSEBRKT    equ  01B1DH ;CharCode =   29  1dH   ScanCode =   27  1bH
K_C_6            equ  0071EH ;CharCode =   30  1eH   ScanCode =    7  07H
K_C_MINUS        equ  00C1FH ;CharCode =   31  1fH   ScanCode =   12  0cH
K_SPACE          equ  03920H ;CharCode =   32  20H   ScanCode =   57  39H
K_EXCLAMPT       equ  00221H ;CharCode =   33  21H   ScanCode =    2  02H
K_2QUOTE         equ  02822H ;CharCode =   34  22H   ScanCode =   40  28H
K_POUND          equ  00423H ;CharCode =   35  23H   ScanCode =    4  04H
K_DOLLAR         equ  00524H ;CharCode =   36  24H   ScanCode =    5  05H
K_PERCENT        equ  00625H ;CharCode =   37  25H   ScanCode =    6  06H
K_AMPERSAND      equ  00826H ;CharCode =   38  26H   ScanCode =    8  08H
K_1QUOTE         equ  02827H ;CharCode =   39  27H   ScanCode =   40  28H
K_OPENPAREN      equ  00A28H ;CharCode =   40  28H   ScanCode =   10  0aH
K_CLOSEPAREN     equ  0OB29H ;CharCode =   41  29H   ScanCode =   11  0bH
K_STAR           equ  0092AH ;CharCode =   42  2AH   ScanCode =    9  09H
K_PLUS           equ  00D2BH ;CharCode =   43  2BH   ScanCode =   13  0dH
K_COMMA          equ  0332CH ;CharCode =   44  2CH   ScanCode =   51  33H
K_MINUS          equ  00C2DH ;CharCode =   45  2DH   ScanCode =   12  0cH
K_PERIOD         equ  0342EH ;CharCode =   46  2EH   ScanCode =   52  34H
K_SLASH          equ  0352FH ;CharCode =   47  2FH   ScanCode =   53  35H
K_0              equ  00B30H ;CharCode =   48  30H   ScanCode =   11  0bH
K_1              equ  00231H ;CharCode =   49  31H   ScanCode =    2  02H
K_2              equ  00332H ;CharCode =   50  32H   ScanCode =    3  03H
K_3              equ  00433H ;CharCode =   51  33H   ScanCode =    4  04H
K_4              equ  00534H ;CharCode =   52  34H   ScanCode =    5  05H
K_5              equ  00635H ;CharCode =   53  35H   ScanCode =    6  06H
K_6              equ  00736H ;CharCode =   54  36H   ScanCode =    7  07H
K_7              equ  00837H ;CharCode =   55  37H   ScanCode =    8  08H
K_8              equ  00938H ;CharCode =   56  38H   ScanCode =    9  09H
K_9              equ  00A39H ;CharCode =   57  39H   ScanCode =   10  0aH
K_COLON          equ  0273AH ;CharCode =   58  3AH   ScanCode =   39  27H
K_SEMICOLON      equ  0273BH ;CharCode =   59  3BH   ScanCode =   39  27H
K_LTHAN          equ  0333CH ;CharCode =   60  3CH   ScanCode =   51  33H
K_EQUAL          equ  00C3DH ;CharCode =   61  3DH   ScanCode =   12  0cH
K_GTHAN          equ  0343EH ;CharCode =   62  3EH   ScanCode =   52  34H
K_QUESTION       equ  0353FH ;CharCode =   63  3FH   ScanCode =   53  35H
K_AT             equ  00340H ;CharCode =   64  40H   ScanCode =    3  03H
K_UC_A           equ  01E41H ;CharCode =   65  41H   ScanCode =   30  1eH
K_UC_B           equ  03042H ;CharCode =   66  42H   ScanCode =   48  30H
K_UC_C           equ  02E43H ;CharCode =   67  43H   ScanCode =   46  2eH
K_UC_D           equ  02044H ;CharCode =   68  44H   ScanCode =   32  20H
K_UC_E           equ  01245H ;CharCode =   69  45H   ScanCode =   18  12H
K_UC_F           equ  02146H ;CharCode =   70  46H   ScanCode =   33  21H
K_UC_G           equ  02247H ;CharCode =   71  47H   ScanCode =   34  22H
K_UC_H           equ  02348H ;CharCode =   72  48H   ScanCode =   35  23H
K_UC_I           equ  01749H ;CharCode =   73  49H   ScanCode =   23  17H
K_UC_J           equ  0244AH ;CharCode =   74  4AH   ScanCode =   36  24H
K_UC_K           equ  0254BH ;CharCode =   75  4BH   ScanCode =   37  25H
K_UC_L           equ  0264CH ;CharCode =   76  4CH   ScanCode =   38  26H
K_UC_M           equ  0324DH ;CharCode =   77  4DH   ScanCode =   50  32H
K_UC_N           equ  0314EH ;CharCode =   78  4EH   ScanCode =   49  31H
K_UC_O           equ  0184FH ;CharCode =   79  4FH   ScanCode =   24  18H
K_UC_P           equ  01950H ;CharCode =   80  50H   ScanCode =   25  19H
K_UC_Q           equ  01051H ;CharCode =   81  51H   ScanCode =   16  10H
K_UC_R           equ  01322H ;CharCode =   82  22H   ScanCode =   19  13H
K_UC_S           equ  01F53H ;CharCode =   83  53H   ScanCode =   31  1fH
K_UC_T           equ  01454H ;CharCode =   84  54H   ScanCode =   20  14H
K_UC_U           equ  01655H ;CharCode =   85  55H   ScanCode =   22  16H
K_UC_V           equ  02F56H ;CharCode =   86  56H   ScanCode =   47  2fH
K_UC_W           equ  01157H ;CharCode =   87  57H   ScanCode =   17  11H
K_UC_X           equ  02D58H ;CharCode =   88  58H   ScanCode =   45  2dH
K_UC_Y           equ  01559H ;CharCode =   89  59H   ScanCode =   21  15H
K_UC_Z           equ  02C5AH ;CharCode =   90  5AH   ScanCode =   44  2cH
K_OPENBRKT       equ  01A5BH ;CharCode =   91  5BH   ScanCode =   26  1aH
K_BACKSLASH      equ  02B5CH ;CharCode =   92  5CH   ScanCode =   43  2bH
K_CLOSEBRKT      equ  01B5DH ;CharCode =   93  5DH   ScanCode =   27  1bH
K_CARET          equ  0075EH ;CharCode =   94  5EH   ScanCode =   7   07H
K_UNDERSCORE     equ  00C5FH ;CharCode =   95  5FH   ScanCode =   12  0cH
K_BACKQUOTE      equ  02960H ;CharCode =   96  60H   ScanCode =   41  29H
K_LC_a           equ  01E61H ;CharCode =   97  61H   ScanCode =   30  1eH
K_LC_b           equ  03062H ;CharCode =   98  62H   ScanCode =   48  30H
K_LC_c           equ  02E63H ;CharCode =   99  63H   ScanCode =   46  2eH
K_LC_d           equ  02064H ;CharCode =  100  64H   ScanCode =   32  20H
K_LC_e           equ  01265H ;CharCode =  101  65H   ScanCode =   18  12H
K_LC_f           equ  02166H ;CharCode =  102  66H   ScanCode =   33  21H
K_LC_g           equ  02267H ;CharCode =  103  67H   ScanCode =   34  22H
K_LC_h           equ  02368H ;CharCode =  104  68H   ScanCode =   35  23H
K_LC_i           equ  01769H ;CharCode =  105  69H   ScanCode =   23  17H
K_LC_j           equ  0246AH ;CharCode =  106  6AH   ScanCode =   36  24H
K_LC_k           equ  0256BH ;CharCode =  107  6BH   ScanCode =   37  25H
K_LC_l           equ  0266CH ;CharCode =  108  6CH   ScanCode =   38  26H
K_LC_m           equ  0326DH ;CharCode =  109  6DH   ScanCode =   50  32H
K_LC_n           equ  0316EH ;CharCode =  110  6EH   ScanCode =   49  31H
K_LC_o           equ  0186FH ;CharCode =  111  6FH   ScanCode =   24  18H
K_LC_p           equ  01970H ;CharCode =  112  70H   ScanCode =   25  19H
K_LC_q           equ  01071H ;CharCode =  113  71H   ScanCode =   16  10H
K_LC_r           equ  01372H ;CharCode =  114  72H   ScanCode =   19  13H
K_LC_s           equ  01f73H ;CharCode =  115  73H   ScanCode =   31  1fH
K_LC_t           equ  01474H ;CharCode =  116  74H   ScanCode =   20  14H
K_LC_u           equ  01675H ;CharCode =  117  75H   ScanCode =   22  16H
K_LC_v           equ  02f76H ;CharCode =  118  76H   ScanCode =   47  2fH
K_LC_w           equ  01177H ;CharCode =  119  77H   ScanCode =   17  11H
K_LC_x           equ  02d78H ;CharCode =  120  78H   ScanCode =   45  2dH
K_LC_y           equ  01579H ;CharCode =  121  79H   ScanCode =   21  15H
K_LC_z           equ  02c7AH ;CharCode =  122  7AH   ScanCode =   44  2cH
K_OPENCRLYBRKT   equ  0 17BH ;CharCode =  123  7BH   ScanCode =   26  1aH
K_VERTICALBAR    equ  0 17CH ;CharCode =  124  7CH   ScanCode =   43  2bH
K_CLOSECRLYBRKT  equ  0 17DH ;CharCode =  125  7DH   ScanCode =   27  1BH
K_CEDILLA        equ  0 17EH ;CharCode =  126  7EH   ScanCode =   41  29H
K_127            equ  0 17FH ;CharCode =  127  7FH   ScanCode =    0  00H

;-------------FUNCTION KEYS -------------
K_F1             equ  03B00H ;CharCode =    0  00H   ScanCode =   59  3bH
K_F2             equ  03C00H ;CharCode =    0  00H   ScanCode =   60  3cH
K_F3             equ  03D00H ;CharCode =    0  00H   ScanCode =   61  3dH
K_F4             equ  03E00H ;CharCode =    0  00H   ScanCode =   62  3eH
K_F5             equ  03F00H ;CharCode =    0  00H   ScanCode =   63  3fH
K_F6             equ  04000H ;CharCode =    0  00H   ScanCode =   64  40H
K_F7             equ  04100H ;CharCode =    0  00H   ScanCode =   65  41H
K_F8             equ  04200H ;CharCode =    0  00H   ScanCode =   66  42H
K_F9             equ  04300H ;CharCode =    0  00H   ScanCode =   67  43H
K_F10            equ  04400H ;CharCode =    0  00H   ScanCode =   68  44H
K_F11            equ  08500H ;CharCode =    0  00H   ScanCode =  133  85H
K_F12            equ  08600H ;CharCode =    0  00H   ScanCode =  134  86H

;------------- KEY PAD
K_HOME           equ  04700H ;CharCode =    0  00H   ScanCode =   71  47H
K_UP             equ  04800H ;CharCode =    0  00H   ScanCode =   72  48H
K_PGUP           equ  04900H ;CharCode =    0  00H   ScanCode =   73  49H
K_LEFT           equ  04B00H ;CharCode =    0  00H   ScanCode =   75  4bH
K_CENTER         equ  04C00H ;CharCode =    0  00H   ScanCode =   76  4CH
K_RIGHT          equ  04D00H ;CharCode =    0  00H   ScanCode =   77  4dH
K_END            equ  04F00H ;CharCode =    0  00H   ScanCode =   79  4fH
K_DOWN           equ  05000H ;CharCode =    0  00H   ScanCode =   80  50H
K_PGDN           equ  05100H ;CharCode =    0  00H   ScanCode =   81  51H
K_INS            equ  05200H ;CharCode =    0  00H   ScanCode =   82  52H
K_DEL            equ  05300H ;CharCode =    0  00H   ScanCode =   83  53H

;------------- GRAY KEYPAD
K_GRAY_HOME      equ  047E0H ;CharCode =  224  e0H   ScanCode =   71  47H
K_GRAY_UP        equ  048E0H ;CharCode =  224  e0H   ScanCode =   72  48H
K_GRAY_PGUP      equ  049E0H ;CharCode =  224  e0H   ScanCode =   73  49H
K_GRAY_LEFT      equ  04bE0H ;CharCode =  224  e0H   ScanCode =   75  4bH
K_GRAY_CENTER    equ  04CE0H ;CharCode =  224  e0H   ScanCode =   76  4CH
K_GRAY_RIGHT     equ  04dE0H ;CharCode =  224  e0H   ScanCode =   77  4dH
K_GRAY_END       equ  04fE0H ;CharCode =  224  e0H   ScanCode =   79  4fH
K_GRAY_DOWN      equ  050E0H ;CharCode =  224  e0H   ScanCode =   80  50H
K_GRAY_PGDN      equ  051E0H ;CharCode =  224  e0H   ScanCode =   81  51H
K_GRAY_INS       equ  052E0H ;CharCode =  224  e0H   ScanCode =   82  52H
K_GRAY_DEL       equ  053E0H ;CharCode =  224  e0H   ScanCode =   83  53H

;------------- OTHER GRAY KEYS
K_GRAY_FSLASH    equ  02FE0H ;CharCode =  224  e0H   ScanCode =   47  2fH
K_GRAY_STAR      equ  0372AH ;CharCode =   42  2aH   ScanCode =   55  37H
K_GRAY_MINUS     equ  04A2DH ;CharCode =   45  2dH   ScanCode =   74  4aH
K_GRAY_PLUS      equ  04E2AH ;CharCode =   42  2aH   ScanCode =   78  4eH
K_GRAY_EQUAL     equ  0oD3DH ;CharCode =   61  3dH   ScanCode =   13  0dH
K_GRAY_ENTER     equ  0E00DH ;CharCode =   13  0dH   ScanCode =  224  e0H

;-------------ALTERNATE KEYS
K_A_1            equ  07800H ;CharCode =    0  00H   ScanCode =  120  78H
K_A_2            equ  07900H ;CharCode =    0  00H   ScanCode =  121  79H
K_A_3            equ  07A00H ;CharCode =    0  00H   ScanCode =  122  7aH
K_A_4            equ  07B00H ;CharCode =    0  00H   ScanCode =  123  7bH
K_A_5            equ  07C00H ;CharCode =    0  00H   ScanCode =  124  7cH
K_A_6            equ  07D00H ;CharCode =    0  00H   ScanCode =  125  7dH
K_A_7            equ  07E00H ;CharCode =    0  00H   ScanCode =  126  7eH
K_A_8            equ  07F00H ;CharCode =    0  00H   ScanCode =  127  7fH
K_A_9            equ  08000H ;CharCode =    0  00H   ScanCode =  128  80H
K_A_0            equ  08100H ;CharCode =    0  00H   ScanCode =  129  81H
K_A_Q            equ  01000H ;CharCode =    0  00H   ScanCode =   16  10H
K_A_W            equ  01100H ;CharCode =    0  00H   ScanCode =   17  11H
K_A_E            equ  01200H ;CharCode =    0  00H   ScanCode =   18  12H
K_A_R            equ  01300H ;CharCode =    0  00H   ScanCode =   19  13H
K_A_T            equ  01400H ;CharCode =    0  00H   ScanCode =   20  14H
K_A_Y            equ  01500H ;CharCode =    0  00H   ScanCode =   21  15H
K_A_U            equ  01600H ;CharCode =    0  00H   ScanCode =   22  16H
K_A_I            equ  01700H ;CharCode =    0  00H   ScanCode =   23  17H
K_A_O            equ  01800H ;CharCode =    0  00H   ScanCode =   24  18H
K_A_P            equ  01900H ;CharCode =    0  00H   ScanCode =   25  19H
K_A_A            equ  01300H ;CharCode =    0  00H   ScanCode =   30  1eH
K_A_S            equ  0IF00H ;CharCode =    0  00H   ScanCode =   31  1fH
K_A_D            equ  02000H ;CharCode =    0  00H   ScanCode =   32  20H
K_A_F            equ  02100H ;CharCode =    0  00H   ScanCode =   33  21H
K_A_G            equ  02200H ;CharCode =    0  00H   ScanCode =   34  22H
K_A_H            equ  02300H ;CharCode =    0  00H   ScanCode =   35  23H
K_A_J            equ  02400H ;CharCode =    0  00H   ScanCode =   36  24H
K_A_K            equ  02500H ;CharCode =    0  00H   ScanCode =   37  25H
K_A_L            equ  02600H ;CharCode =    0  00H   ScanCode =   38  26H
K_A_Z            equ  02C00H ;CharCode =    0  00H   ScanCode =   44  2cH
K_A_X            equ  02D00H ;CharCode =    0  00H   ScanCode =   45  2dH
K_A_C            equ  02E00H ;CharCode =    0  00H   ScanCode =   46  2eH
K_A_V            equ  02F00H ;CharCode =    0  00H   ScanCode =   47  2fH
K_A_B            equ  03000H ;CharCode =    0  00H   ScanCode =   48  30H
K_A_N            equ  03100H ;CharCode =    0  00H   ScanCode =   49  31H
K_A_M            equ  03200H ;CharCode =    0  00H   ScanCode =   50  32H
K_A_1            equ  07800H ;CharCode =    0  00H   ScanCode =  120  78H
K_A_2            equ  07900H ;CharCode =    0  00H   ScanCode =  121  79H
K_A_3            equ  07A00H ;CharCode =    0  00H   ScanCode =  122  7aH
K_A_4            equ  07B00H ;CharCode =    0  00H   ScanCode =  123  7bH
K_A_5            equ  07C00H ;CharCode =    0  00H   ScanCode =  124  7cH
K_A_6            equ  07D00H ;CharCode =    0  00H   ScanCode =  125  7dH
K_A_7            equ  07E00H ;CharCode =    0  00H   ScanCode =  126  7eH
K_A_8            equ  07F00H ;CharCode =    0  00H   ScanCode =  127  7fH
K_A_9            equ  08000H ;CharCode =    0  00H   ScanCode =  128  80H
K_A_0            equ  08100H ;CharCode =    0  00H   ScanCode =  129  81H
K_A_MINUS        equ  08200H ;CharCode =    0  00H   ScanCode =  130  82H
K_A_EQUAL        equ  08300H ;CharCode =    0  00H   ScanCode =  131  83H
K_A_SPACE        equ  03920H ;CharCode =   32  20H   ScanCode =   57  39H same as K_A_SPACE
K_A_F1           equ  06800H ;CharCode =    0  00H   ScanCode =  104  68H
K_A_F2           equ  06900H ;CharCode =    0  00H   ScanCode =  105  69H
K_A_F3           equ  06A00H ;CharCode =    0  00H   ScanCode =  106  6aH
K_A_F4           equ  06B00H ;CharCode =    0  00H   ScanCode =  107  6bH
K_A_F5           equ  06C00H ;CharCode =    0  00H   ScanCode =  108  6cH
K_A_F6           equ  06D00H ;CharCode =    0  00H   ScanCode =  109  6dH
K_A_F7           equ  06E00H ;CharCode =    0  00H   ScanCode =  110  6eH
K_A_F8           equ  06F00H ;CharCode =    0  00H   ScanCode =  111  6fH
K_A_F9           equ  07000H ;CharCode =    0  00H   ScanCode =  112  70H
K_A_F10          equ  07100H ;CharCode =    0  00H   ScanCode =  113  71H
K_A_F11          equ  08B00H ;CharCode =    0  00H   ScanCode =  139  8bH
K_A_F12          equ  08C00H ;CharCode =    0  00H   ScanCode =  140  8cH
K_A_ESC          equ  00000H ;CharCode =       00H   ScanCode =
K_A_BACKQUOTE    equ  02900H ;CharCode =    0  00H   ScanCode =   41  29H
K_A_BACKSPACE    equ  00E00H ;CharCode =    0  00H   ScanCode =   14  0eH
K_A_TAB          equ  00000H ;CharCode =             ScanCode =
K_A_OPENBRKT     equ  01A00H ;CharCode =    0  00H   ScanCode =   26  1aH
K_A_CLOSEBRKT    equ  01B00H ;CharCode =    0  00H   ScanCode =   27  1bH
K_A_BACKSLASH    equ  02B00H ;CharCode =    0  00H   ScanCode =   43  2bH
K_A_SEMICOLON    equ  02700H ;CharCode =    0  00H   ScanCode =   39  27H
K_A_QUOTE        equ  02800H ;CharCode =    0  00H   ScanCode =   40  28H
K_A_ENTER        equ  01C00H ;CharCode =    0  00H   ScanCode =   28  1cH
K_A_COMMA        equ  03300H ;CharCode =    0  00H   ScanCode =   51  33H
K_A_PERIOD       equ  03400H ;CharCode =    0  00H   ScanCode =   52  34H
K_A_SLASH        equ  03500H ;CharCode =    0  00H   ScanCode =   53  35H
K_A_UP           equ  00800H ;CharCode =    0  00H   ScanCode =    8  08H
K_A_LEFT         equ  00400H ;CharCode =    0  00H   ScanCode =    4  04H
K_A_DOWN         equ  00200H ;CharCode =    0  00H   ScanCode =    2  02H
K_A_RIGHT        equ  00600H ;CharCode =    0  00H   ScanCode =    6  06H
;K_A_DEL          equ  0      ;CharCode =    0  00H   ScanCode =
K_A_CENTER       equ  00005H ;CharCode =    5  00H   ScanCode =    0  00H
K_A_END          equ  00100H ;CharCode =    0  00H   ScanCode =    1  01H
K_A_PGDN         equ  00200H ;CharCode =    0  00H   ScanCode =    3  02H
K_A_PGUP         equ  09000H ;CharCode =    0  00H   ScanCode =    9  09H
;K_A_INS          equ  0      ;CharCode =    0  00H   ScanCode =
K_A_HOME         equ  00700H ;CharCode =    0  00H   ScanCode =    7  07H
K_A_GRAY_INS     equ  0A200H ;CharCode =    0  00H   ScanCode =  162  a2H
K_A_GRAY_HOME    equ  09700H ;CharCode =    0  00H   ScanCode =  151  97H
K_A_GRAY_PGUP    equ  09900H ;CharCode =    0  00H   ScanCode =  153  99H
K_A_GRAY_DEL     equ  0A300H ;CharCode =    0  00H   ScanCode =  163  a3H
K_A_GRAY_CENTER  equ  00005H ;CharCode =    5  00H   ScanCode =    0  00H
K_A_GRAY_END     equ  09F00H ;CharCode =    0  00H   ScanCode =  159  9fH
K_A_GRAY_PGDN    equ  0A100H ;CharCode =    0  00H   ScanCode =  161  a1H
K_A_GRAY_UP      equ  09800H ;CharCode =    0  00H   ScanCode =  152  98H
K_A_GRAY_LEFT    equ  09B00H ;CharCode =    0  00H   ScanCode =  155  9bH
K_A_GRAY_DOWN    equ  0A000H ;CharCode =    0  00H   ScanCode =  160  a0H
K_A_GRAY_RIGHT   equ  09D00H ;CharCode =    0  00H   ScanCode =  157  9dH
K_A_GRAY_STAR    equ  03700H ;CharCode =    0  00H   ScanCode =   55  37H
K_A_GRAY_SLASH   equ  0A400H ;CharCode =    0  00H   ScanCode =  164  a4H
K_A_GRAY_MINUS   equ  04A00H ;CharCode =    0  00H   ScanCode =   74  4aH
K_A_GRAY_ENTER   equ  0A600H ;CharCode =    0  00H   ScanCode =  166  a6H
K_A_GRAY_PLUS    equ  04E00H ;CharCode =    0  00H   ScanCode =   78  4eH

;--------- CONTROL KEYS
;K_C_PRTSC        equ         ;CharCode =    0  00H   ScanCode =
K_C_SPACE        equ  03920H ;CharCode =   32  20H   ScanCode =   57  39H same as K_A_SPACE
K_C_ENTER        equ  01C0AH ;CharCode =   10  0aH   ScanCode =   28  1cH
K_C_LEFT         equ  07300H ;CharCode =    0  00H   ScanCode =  115  73H
K_C_RIGHT        equ  07400H ;CharCode =    0  00H   ScanCode =  116  74H
K_C_END          equ  07500H ;CharCode =    0  00H   ScanCode =  117  75H
K_C_PGDN         equ  07600H ;CharCode =    0  00H   ScanCode =  118  76H
K_C_HOME         equ  07700H ;CharCode =    0  00H   ScanCode =  119  77H
K_C_PGUP         equ  08400H ;CharCode =    0  00H   ScanCode =  132  84H
K_C_UP           equ  08D00H ;CharCode =    0  00H   ScanCode =  141  8dH
K_C_DOWN         equ  09100H ;CharCode =    0  00H   ScanCode =  145  91H
K_C_CENTER       equ  08F00H ;CharCode =    0  00H   ScanCode =  143  8fH
K_C_INS          equ  02E00H ;CharCode =    0  00H   ScanCode =  146  2eH
K_C_DEL          equ  02F00H ;CharCode =    0  00H   ScanCode =  147  2fH
K_C_F1           equ  05E00H ;CharCode =    0  00H   ScanCode =   94  5eH
K_C_F2           equ  05F00H ;CharCode =    0  00H   ScanCode =   95  5fH
K_C_F3           equ  06000H ;CharCode =    0  00H   ScanCode =   96  60H
K_C_F4           equ  06100H ;CharCode =    0  00H   ScanCode =   97  61H
K_C_F5           equ  06200H ;CharCode =    0  00H   ScanCode =   98  62H
K_C_F6           equ  06300H ;CharCode =    0  00H   ScanCode =   99  63H
K_C_F7           equ  06400H ;CharCode =    0  00H   ScanCode =  100  64H
K_C_F8           equ  06500H ;CharCode =    0  00H   ScanCode =  101  65H
K_C_F9           equ  06600H ;CharCode =    0  00H   ScanCode =  102  66H
K_C_F10          equ  06700H ;CharCode =    0  00H   ScanCode =  103  67H
K_C_F11          equ  08900H ;CharCode =    0  00H   ScanCode =  137  89H
K_C_F12          equ  08A00H ;CharCode =    0  00H   ScanCode =  138  8aH
K_C_GRAY_HOME    equ  07700H ;CharCode =  224  e0H   ScanCode =  119  77H
K_C_GRAY_END     equ  07500H ;CharCode =  224  e0H   ScanCode =  117  75H
K_C_GRAY_LEFT    equ  07300H ;CharCode =  224  e0H   ScanCode =  115  73H
K_C_GRAY_RIGHT   equ  07400H ;CharCode =  224  e0H   ScanCode =  116  74H
K_C_GRAY_UP      equ  08DE0H ;CharCode =  224  e0H   ScanCode =  141  8df
K_C_GRAY_DOWN    equ  091E0H ;CharCode =  224  e0H   ScanCode =  145  91H
K_C_GRAY_PGDN    equ  07600H ;CharCode =  224  e0H   ScanCode =  118  76H
K_C_GRAY_PGUP    equ  08400H ;CharCode =  224  e0H   ScanCode =  132  84H
K_C_GRAY_CENTER  equ  08F00H ;CharCode =  224  e0H   ScanCode =  143  8fH
K_C_GRAY_INS     equ  092E0H ;CharCode =  224  e0H   ScanCode =  146  92H
K_C_GRAY_DEL     equ  093E0H ;CharCode =  224  e0H   ScanCode =  147  93H
K_C_GRAY_SLASH   equ  09500H ;CharCode =    0  00H   ScanCode =  149  95H
K_C_GRAY_STAR    equ  09600H ;CharCode =    0  00H   ScanCode =  150  96H
K_C_GRAY_MINUS   equ  08E00H ;CharCode =    0  00H   ScanCode =  142  8eH
K_C_GRAY_PLUS    equ  09000H ;CharCode =    0  00H   ScanCode =  144  90H
K_C_GRAY_ENTER   equ  0E010H ;CharCode =   10  00H   ScanCode =  224  E0H

;--------- SHIFT KEYS
K_S_F1           equ  05400H ;CharCode =    0  00H   ScanCode =   84  54H
K_S_F2           equ  05500H ;CharCode =    0  00H   ScanCode =   85  55H
K_S_F3           equ  05600H ;CharCode =    0  00H   ScanCode =   86  56H
K_S_F4           equ  05700H ;CharCode =    0  00H   ScanCode =   87  57H
K_S_F5           equ  05800H ;CharCode =    0  00H   ScanCode =   88  58H
K_S_F6           equ  05900H ;CharCode =    0  00H   ScanCode =   89  59H
K_S_F7           equ  05A00H ;CharCode =    0  00H   ScanCode =   90  5aH
K_S_F8           equ  05B00H ;CharCode =    0  00H   ScanCode =   91  5bH
K_S_F9           equ  05C00H ;CharCode =    0  00H   ScanCode =   92  5cH
K_S_F10          equ  05D00H ;CharCode =    0  00H   ScanCode =   93  5dH
K_S_F11          equ  08700H ;CharCode =    0  00H   ScanCode =  135  87H
K_S_F12          equ  08800H ;CharCode =    0  00H   ScanCode =  136  88H
;K_S_NUL          equ  0      ;CharCode =             ScanCode =
K_S_TAB          equ  00F00H ;CharCode =    0  00H   ScanCode =   15  0fH
K_S_ENTER        equ  01C0AH ;CharCode =   10  0aH   ScanCode =   28  1cH
K_S_LEFT         equ  04B34H ;CharCode =   52  34H   ScanCode =   75  4bH
K_S_RIGHT        equ  04D36H ;CharCode =   54  36H   ScanCode =   77  4dH
K_S_END          equ  04F31H ;CharCode =   49  31H   ScanCode =   79  4fH
K_S_PGDN         equ  05133H ;CharCode =   51  33H   ScanCode =   81  51H
K_S_HOME         equ  04737H ;CharCode =   55  37H   ScanCode =   71  47H
K_S_PGUP         equ  04939H ;CharCode =   57  39H   ScanCode =   73  49H
K_S_INS          equ  05230H ;CharCode =   48  30H   ScanCode =   82  52H
K_S_DEL          equ  0532EH ;CharCode =   46  2eH   ScanCode =   83  53H
K_S_UP           equ  04838H ;CharCode =   56  38H   ScanCode =   72  48H
K_S_DOWN         equ  05032H ;CharCode =   50  32H   ScanCode =   80  50H
K_S_CENTER       equ  04C35H ;CharCode =   53  35H   ScanCode =   76  4cH
K_S_GRAY_ENTER   equ  01CE0H ;CharCode =  224  e0H   ScanCode =   28  1cH
K_S_GRAY_LEFT    equ  04BE0H ;CharCode =  224  e0H   ScanCode =   75  4bH
K_S_GRAY_RIGHT   equ  04DE0H ;CharCode =  224  e0H   ScanCode =   77  4dH
K_S_GRAY_END     equ  04FE0H ;CharCode =  224  e0H   ScanCode =   79  4fH
K_S_GRAY_PGDN    equ  051E0H ;CharCode =  224  e0H   ScanCode =   81  51H
K_S_GRAY_HOME    equ  047E0H ;CharCode =  224  e0H   ScanCode =   71  47H
K_S_GRAY_PGUP    equ  049E0H ;CharCode =  224  e0H   ScanCode =   73  49H
K_S_GRAY_INS     equ  052E0H ;CharCode =  224  e0H   ScanCode =   82  52H
K_S_GRAY_DEL     equ  053E0H ;CharCode =  224  e0H   ScanCode =   83  53H
K_S_GRAY_UP      equ  048E0H ;CharCode =  224  e0H   ScanCode =   72  48H
K_S_GRAY_DOWN    equ  050E0H ;CharCode =  224  e0H   ScanCode =   80  50H
K_S_GRAY_CENTER  equ  0E013H ;CharCode =   13  0dH   ScanCode =  224  E0H

