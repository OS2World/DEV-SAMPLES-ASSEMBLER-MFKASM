;---------------------------------------------------------------------------;
; M.F.Kaplon  Begun:Mon  07-06-1992    Revised: Mon  07-06-1992
; Title : shutdown.asm
;
; ShutDown System
;
; Used 286 routines for simpler KB handling
;
; For System Function Calls
;
; 1 - Use the Pascal Calling Convention which means
; 2 - Using .MODEL SMALL
; 3 - Need a stack certainly greater than the default 1K of .STACK 2K OK this program
;
; Assembling and Linking : used a CMD file and Environment Variables
;
; cmd file to assemble and link is named mlc-l286
; and should be called as   :  mlc-l286 filename
; The cmd file assumes that "filename" is in d:\os2_asm
; Content of mlc-link286
;  ml /c d:\os2_asm\%1.asm
;  link286 /PM:VIO /ALIGN:16 /E %1.obj ;
;  del *.obj
;
; My source files are in D:\os2_asm and I make my calls from the C:
; root directory so that the EXE files and the OBJ file are in C:\
; and the EXE file has same name as source file.
; If you are assembling and linking more than one then you have to
; make appropriate changes. The above does not make a map or list file
;
; I get two warning messages
;
; LINK : warning L4036: no automatic data segment
;
; This message has to do with no DGROUP being defined
; It can be suppressed with DATA NONE in a "DEF" file
;---------------------------------------------------------------------------;


.286
.MODEL           SMALL,SYSCALL ,OS_OS2

 INCLUDE         d:\os2_asm\286_dos.mac       ;macros using DOS calls
 INCLUDE         d:\os2_asm\equates.inc
 INCLUDELIB      c:\toolkt20\os2lib\os2286.lib


.STACK    8192   ;8K stack

.DATA
$DefineNumBufs
$DefineKbdBufs
$DefineVioBufs
$DefineDosBufs

.CODE

startup:                         ;need to do this way with os/2

$PopMsg -1,-1,"<Esc> aborts Shutdown - <Enter> to Continue System ShutDown",Red,White

.IF Key == K_ENTER
    $Printf s,"When All Disc Activity has Ceased _ Reboot or Turn System Off"
    $DosShutdown
.ENDIF

exit0: $DosExit                  ;exit routine

END   startup                           ;required

