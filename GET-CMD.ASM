;---------------------------------------------------------------------------;
; M.F.Kaplon  Begun:Mon  07-27-1992   Revised:Wed  07-29-1992
; Title : get-cmd.asm
;
; Get the command line using OS/2 call DosGetInfoBlocks
; In the command line the program name is 0 terminated and
; the remaining part of the command ine is 0 terminated
;
; Lists program name and # of space separated params passed on command line
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

IFDEF NUMBUFS                     ;To use  UNCOMMENT NUMBUFS equate above
   $DefineNumBufs
ENDIF

nwritten         DWORD   ?        ;needed for DosWrite
NumParms         DWORD   0
;Command Line data
ProgName          BYTE   9 dup(0) ;program name

.CODE

startup:                         ;need to do this way with flat model

;----------- get command line ------------

$GetCmdLine
mov     edi,offset  ProgName   ;initialize to zero
;-------------copy program name from command line to ProgName--------------
.WHILE byte ptr [esi] != 0     ;get program name
      movsb
.ENDW

inc    esi                     ;now points to  1st space after command name
.WHILE  byte ptr [esi] != 0    ;go to end of command line
     .WHILE byte ptr [esi] == ' '
          inc   esi
     .ENDW
     .IF byte ptr [esi] != ' ' && byte ptr [esi] != 0; if a space
         inc    esi
         inc    NumParms
         .WHILE byte ptr [esi] != ' ' && byte ptr [esi] != 0
              inc   esi
         .ENDW
     .ENDIF
.ENDW

$DosWrite SIZEOF ProgName,offset ProgName,stdout
$Printf s," Number of Space Separated Parameters on Command Line = ",dw,NumParms
$NewLine

$DosExit

END   startup                  ;required
