;---------------------------------------------------------------------------;
; M.F.Kaplon  Begun:Mon  07-27-1992   Revised:Wed  07-29-1992
; Title : kb-rate.asm
;
; Set the Keyboard Typematic Rate - Passed In at KB if not Passed in
; uses Default Values if none passed in
; Category 4 function 54h.
;
; Call as kb-rate delay rate
;
; delay = 5 and rate = 14 are good default values
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
;---------------------------------------------------------------------------;
;

.386             ;preceeding .MODEL makes USE32 default
.MODEL           FLAT,SYSCALL,OS_OS2
;---------- Conditionally required equates -------------

NUMBUFS             equ  1     ; Uncomment if need number routines
;

NOWIN               equ  1     ;Not a PM application

INCLUDE        c:\toolkt20\asm\os2inc\os2def.inc ;structure defns includes POINTL
INCLUDELIB     c:\toolkt20\os2lib\os2386.lib     ;Library

INCLUDE        d:\os2_asm\equs386.inc       ;equates : MFK
INCLUDE        d:\os2_asm\386_dos.mac       ;macros using DOS calls : MFK

.STACK    8096   ;8K stack

.DATA

IFDEF NUMBUFS                      ;To use  UNCOMMENT NUMBUFS equate above
   $DefineNumBufs
ENDIF
nwritten        DWORD   ?

;Command Line data
ppTIB           DWORD   ?        ;Address of pointer to TIB
ppPIB           DWORD   ?        ;Address of pointer to PIB
parm1            BYTE  10 dup(0)  ;ASCII typematic dealy in milliseconds
parm2            BYTE  10 dup(0)  ;ASCII typematic rate in chars per sec
parmerr          BYTE  cr,lf,"No Parameters Passed - Call Program as  KB-Rate kbd kbr  where Typematic",cr,lf,\
                      "Delay in Milliseconds = kbd and  Rate in characters per second = kbr",cr,lf,\
                      "Delay = 5 and Rate = 13 are good default parameter values.",cr,lf
parmerrLen      equ $ - parmerr
parmerr1         BYTE     cr,lf,"Incorrect Codes Passed to Program",cr,lf
;parmerr1Len     equ $ - parmerr1


; data for DosOpen Call
KBDdevice        BYTE   "KBD$",0    ; Keyboard
KBDhandle        DWORD  ?         ; KBD handle returned by call
KBDactcode       DWORD  ?         ; action code returned by call
KBDsize          DWORD  0         ; file size for KBD
KBDattr          DWORD  0         ; file attribute for KBD
KBDopenflag      DWORD  1         ; open flag for KBD
KBDopenmode      DWORD  0042h     ; open mode for KBD
KBDexta          DWORD  0         ; extended attributes for KBD


Category         DWORD  4         ;category
Function         DWORD 54h        ;function -assign session mgr hot key
ParmList         WORD   ?         ;Delay
                 WORD   ?         ;Rate
ParmLnthMax      DWORD  4         ;length of Bytes to be returned
ParmLnthInOut    DWORD  4         ;Length in bytes of parms passed
DataPkt          DWORD  0         ;No Data Packet
DataPktLnthMax   DWORD  0         ;Nothing to be returned
DataPktLnthInOut DWORD  0         ;Nothing Passed

.CODE

startup:                         ;need to do this way with flat model

;----------- get command line ------------
push    offset ppPIB
push    offset ppTIB
call    DosGetInfoBlocks
add     esp,8          ;reset stack pointer
; Address of command line is 4-th DWORD field in PIB
; to access it must be offset as 12
; The command line is 0 terminated
mov     ebx,[ppPIB]    ;ebx = address of the PIB
;add     ebx,12         ;ebx now has address of command line
mov     edi,0          ;initialize to zero
mov     esi,[ebx+12]   ;esi is offset of command line
mov     ecx,0          ;use as counter

.WHILE (byte ptr [esi] != 32)  ;read command line up to first space
        inc     esi
.ENDW

;------------ get # of commands on command line -------------
inc    esi                     ;now points to  1st space after command name
.WHILE  byte ptr [esi] != 0    ;go to end of command line
     .WHILE byte ptr [esi] == ' '
          inc   esi
     .ENDW
     .IF byte ptr [esi] != ' ' && byte ptr [esi] != 0; if a space
         inc    esi
         inc    ecx
         .WHILE byte ptr [esi] != ' ' && byte ptr [esi] != 0
              inc   esi
         .ENDW
     .ENDIF
.ENDW

;------------ if no parameters passed sound alarm -display message and exit
.IF  ecx != 2
    $Alarm
    $DosWrite  parmerrlen,offset parmerr,stdout
    $DosExit
.ENDIF

;----------- now convert parms to numbers ---------------

;----------- first copy to buffer, then convert ---------
mov     esi,[ebx+12]        ;point to start of command line
;------------- get to start of params
.WHILE (byte ptr [esi] != 32)  ;read command line up to first space
        inc     esi
.ENDW

.WHILE (byte ptr [esi] == 32)  ;skip spaces to first parm
        inc     esi
.ENDW

;------------- esi now at start of params -------------

mov     edi,offset parm1    ;destination to store
.WHILE (byte ptr [esi] != ' ')  ;read command line up to next space
        movsb
.ENDW

;------------- skip over intervening spaces --------------
.WHILE (byte ptr [esi] == ' ')  ;read command line up to next space
        inc    esi
.ENDW

mov     edi, offset parm2   ;repeat for next parm
.WHILE (byte ptr [esi] != 0)  ;read command line up to end
        movsb
.ENDW

;------------- now convert to numerics
$ASCIIToDWord parm1        ; result returned in eax
mov      word ptr ParmList,ax         ;ParmList is a WORD
$ASCIIToDWord parm2        ; result returned in eax
mov      ebx,eax             ;save in ebx
mov      word ptr ParmList[2],ax

;----------- get handle for KBD device ---------------
$DosOpen offset KBDdevice,offset KBDhandle,offset KBDactcode,KBDsize,KBDattr,KBDopenflag,KBDopenmode,KBDexta

;------ set typematic rate via Function 54h

$DosDevIOCtl KBDhandle,Category,Function,offset ParmList,ParmLnthMax,offset ParmLnthInOut,DataPkt,DataPktLnthMax,offset DataPktLnthInOut



$DosExit

END   startup                    ;required



