;---------------------------------------------------------------------------;
; M.F.Kaplon  Begun:Wed  07-22-1992   Revised:Tue  08-04-1992
; Title : gethotky.asm
;
; This program will obtain current session hot keys via Keyboard IOCTL;s
; Category 4 function 76h.
;
; For System Function Calls
;
; 1 - Must use the C Calling Convention which means
;     Arguments Pushed on Stack in Reverse Order than declared in function
; 2 - Using .MODEL FLAT when using a pointer, all you have to do is push
;     the offset of the variable since in FLAT model everyting is NEAR
;     in the 32 bit space
; 3 - Uses a 16K stack
;
; cmd file to assemble and link is named mlc-w386
; and should be called as   :  mlc-w386 filename
; The cmd file assumes that "filename" is in d:\os2_asm
; Content of mlc-link386
;
; ml /c d:\os2_asm\%1.asm
; IF errorlevel 1  goto errexit
; link386 /PM:PM /ALIGN:16 /E %1.obj ;
; del *.obj
; quit
; :errexit
; Echo Compile Error NO Link
; --------------------------
;
; My source files are in D:\os2_asm and I make my calls from the C:
; root directory so that the EXE files and the OBJ file are in C:\
; and the EXE file has same name as the source file.
; If you are assembling and linking more than one then you have to
; make appropriate changes. The above does not make a map or list file
;
; I get one warning message
;
; LINK : warning L4036: no automatic data segment
;
; This message has to do with no DGROUP being defined
; It can be suppressed with DATA NONE in a "DEF" file
;
; GETHOTKY reports 3 hot keys Ctrl-Esc Alt-Esc and Alt-Home
; It does not report Alt-Tab which functions same as Alt-Esc
; Yet Alt-Tab is affected by sethotky.exe
;---------------------------------------------------------------------------;
;

.386             ;preceeding .MODEL makes USE32 default
.MODEL           FLAT,SYSCALL,OS_OS2
;---------- Conditionally required equates -------------
NUMBUFS             equ  1     ; Uncomment if need number routines

NOWIN               equ  1     ;Not a PM application

INCLUDE        c:\toolkt20\asm\os2inc\os2def.inc ;structure defns includes POINTL
INCLUDELIB     c:\toolkt20\os2lib\os2386.lib     ;Library

INCLUDE        d:\os2_asm\equs386.inc       ;equates : MFK
INCLUDE        d:\os2_asm\386_dos.mac       ;macros using DOS calls : MFK

PACKET STRUC      ; length is 6 BYTES
  state     word  ?
  makecode  byte  ?
  breakcode byte  ?
  HotKeyId  word  ?
PACKET ENDS

.STACK    8096   ;8K stack

.DATA

IFDEF NUMBUFS                      ;To use  UNCOMMENT NUMBUFS equate above
   $DefineNumBufs
ENDIF

nwritten        DWORD  ?

; data for DosOpen Call
KBDdevice        BYTE   "KBD$",0    ; Keyboard
KBDhandle        DWORD  ?         ; KBD handle returned by call
KBDactcode       DWORD  ?         ; action code returned by call
KBDsize          DWORD  0         ; file size for KBD
KBDattr          DWORD  0         ; file attribute for KBD
KBDopenflag      DWORD  1         ; open flag for KBD
KBDopenmode      DWORD  0012h     ;!! 42h also OK open mode for KBD !!
KBDexta          DWORD  0         ; extended attributes for KBD


Limit            DWORD  ?         ;limit of display loop
Category         DWORD  4         ;category
Function         DWORD 76h        ;function - query session manager hot key
DataPkt          PACKET 3 dup({?,?,?,?})
ParmLnthMax      DWORD  2         ;length of ParmLIst in Bytes
ParmLnthInOut    DWORD  2         ;Length in bytes of parms passed
ParmList          WORD  0         ;#Get  of hot keys supported
DataPktLnthMax   DWORD  6         ;data to be returned - max lenth
DataPktLnthInOut DWORD  0         ;nothing passed

.CODE

startup:                         ;need to do this way with flat model

$DosWriteMsg "Getting KBD Handle from DosOpen"

$DosOpen offset KBDdevice,offset KBDhandle,offset KBDactcode,KBDsize,KBDattr,KBDopenflag,KBDopenmode,KBDexta
$NewLine
$DosWriteMsg "KeyBoardHandle Returned OK"      ;<nl,"Keyboard Handle Returned OK",nl>

;------- set up for function 76h  query session manager hot key for # supported

$DosDevIOCtl KbdHandle,Category,Function,offset ParmList,ParmLnthMax,offset ParmLnthInOut,offset DataPkt, DataPktLnthMax,offset DataPktLnthInOut

$NewLine
$Printf s,"Number of HotKeys Supported = ",w,ParmList

mov    ParmList,1         ;get current # of hot keys
$DosDevIOCtl KbdHandle,Category,Function,offset ParmList,ParmLnthMax,offset ParmLnthInOut,offset DataPkt, DataPktLnthMax,offset DataPktLnthInOut

$NewLine

$Printf s,"Number of HotKeys Defined   = ",w,ParmList ;returns 51015
$NewLine

mov    eax,6
mov    ebx,0
mov    bx,ParmList   ;number of entries
mul    ebx             ;#entires*6
dec    eax
mov    Limit,eax
mov    edi,0
.WHILE  edi <= Limit     ; 6 is size of structure
    $Printf s,"For HotKeyId = ",w,DataPkt[edi].hotkeyid,s,"  State           = ",wb,DataPkt[edi].state

    $NewLine
    $Printf s,"For HotKeyId = ",w,DataPkt[edi].hotkeyid,s,"  Make Scan Code  = ",b,DataPkt[edi].Makecode

    $NewLine
    $Printf s,"For HotKeyId = ",w,DataPkt.hotkeyid[edi],s,"  Break Scan Code = ",b,DataPkt[edi].Breakcode

    $NewLine
    $NewLine
    add    edi,6
.ENDW

$DosExit

END   startup                    ;required

