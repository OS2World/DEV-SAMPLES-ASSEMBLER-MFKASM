;---------------------------------------------------------------------------;
; M.F.Kaplon  Begun:Fri  06-12-1992  Revised:Tue  07-21-1992
; Title : pm-tmplt.asm
;
; This is a sort of bare bones template of a Presentation Manager program
; It also demonstrates setting up a HOOK for theWM_CHAR message
;
;
; INITIALIZES,CREATES MESSAGE QUEUE, REGISTERS CLASS,CREATES STANDARD WINDOW
; ESTABLISHES MAIN MESSAGE LOOP, ESTABLISHES BASIC MAIN WINDOW PROCEDURE :
;
; MainWinProc  which has 'switches' recognizing WM_CHAR,WM_PAINT and
; WM_CREATE calling respectively MainKeyBoard, MainPaint, InitMainWindow
;
; The user may add additional switches recognizing other WM_... and must
; then establish the procedures to respond to that call.
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
;!!!!!!!!!!!!!!  PM PROGRAMS MUST BE LINKED WITH /PM:PM !!!!!!!!!!!!!!
;!!!!!!!!!     But then they Display ONLY THROUGH PM CALLS   !!!!!!!!!
;---------------------------------------------------------------------------;
;

.386             ;preceeding .MODEL makes USE32 default
.MODEL           FLAT,SYSCALL,OS_OS2
;---------- Conditionally required equates -------------
NUMBUFS             equ  1     ; Uncomment if need number routines
;
INCL_WINERRORS      equ  1
INCL_WIN            equ  1

INCLUDE        c:\toolkt20\asm\os2inc\os2def.inc ;structure defns includes POINTL
INCLUDE        c:\toolkt20\asm\os2inc\pmwin.inc  ;structure defns POINTL defn required
INCLUDE        c:\toolkt20\asm\os2inc\pmgpi.inc  ;graphics
INCLUDE        c:\toolkt20\asm\os2inc\pmerr.inc  ;errors
INCLUDE        c:\toolkt20\asm\os2inc\pmshl.inc
INCLUDELIB     c:\toolkt20\os2lib\os2386.lib     ;Library

INCLUDE        d:\os2_asm\equs386.inc       ;equates : MFK
INCLUDE        d:\os2_asm\386_dos.mac       ;macros using DOS calls : MFK
INCLUDE        d:\os2_asm\386_win.mac       ;macros using WIN/GR calls :MFK

;---------- Prototype Definitions for MASM 6.0 -------------
InitMainWindow Proto Near SYSCALL var1:DWORD,var2:DWORD,var3:DWORD
MainPaint      Proto Near SYSCALL var1:DWORD
MainKeyBoard   Proto Near SYSCALL var1:DWORD,var2:DWORD,var3:DWORD


.STACK    8096   ;8K stack

.DATA

IFDEF NUMBUFS                      ;To use  UNCOMMENT NUMBUFS equate above
  $DefineNumBufs
ENDIF
;------------- handles --------
hab            DWORD   ?           ;Anchor block Handle
hmq            DWORD   ?           ;Message Queue Handle
hwndMainFrame  DWORD   ?           ;Handle to Main Frame Window
hwndMain       DWORD   ?           ;Handle to Client window
hps            DWORD   ?           ;Presentation Space Handle

;------------- Threads ----------
ThreadID       DWORD   ?           ;ThreadID
ThreadArg      DWORD   ?           ;ARgument to be passed to Thread

;------------- Return Values --------
TorF           DWORD   ?           ;return value, True or False
PaintRet       DWORD   ?           ;return value from Paint Procedure
RetValue       DWORD   ?           ;return values from calls

;------------- Text Strings --------
szAppName       BYTE   "Main",0    ;Class Name of Window Procedure
szWinTitle      BYTE   "*** TSR ***",0 ;Window Title
msgInitErr      BYTE   "!!! This is in a Message Box !!!",0
textMsg         BYTE   "*** Presentation Manager TSR ***",0


;------------- Text Strings for WinMessageBox calls --------
msgWinChangeSwitchEntry BYTE " : WinChangeSwitchEntry",0
msgWinQuerySwitchList   BYTE " : WinQuerySwitchList",0
msgWinReleaseHook       BYTE " : WinReleaseHook",0
msgWinSetHook           BYTE " : WinSetHook",0

msgDosAllocMem          BYTE " : DosallocMem",0
msgDosCreateThread      BYTE " : DosCreateThread",0
msgDosDevIOCtl          BYTE " : DosDevIOCtl",0
msgDosFreeMem           BYTE " : DosFreeMem",0
msgDosFreeModule        BYTE " : DosFreeModule",0
msgDosKillThread        BYTE " : DosKillThread",0
msgDosLoadModule        BYTE " : DosLoadModule",0
msgDosOpen              BYTE " : DosOpen",0
msgDosQueryProcAddr     BYTE " : DosQueryProcAddr",0

;------------- Styles --------
msgBoxStyle    DWORD   (MB_YESNO OR MB_DEFBUTTON1)
flStyle        DWORD   (CS_SIZEREDRAW OR CS_HITTEST)  ;Window Style
flCtlData      DWORD   (((((FCF_SYSMENU        OR \   ;Window Control Styles
                            FCF_MINMAX)        OR \
                            FCF_SHELLPOSITION) OR \
                            FCF_TASKLIST)      OR \
                            FCF_SIZEBORDER)    OR \
                            FCF_TITLEBAR )

;------------- structures --------
quemsg          QMSG    {,,,,,,}   ;Queue message structure
rect           RECTL   {,,,}       ;Rectangle structure

;-------------- DosOpen -----------------
DevId           BYTE   "KBD$",0     ;Input  Keyboard Device
DevHandle      DWORD   ?            ;Output Device Handle
DevActionTaken DWORD   ?            ;Output Action Taken
DevSize        DWORD   0            ;Input  Logical Size 0 for devuces
DevAttribute   DWORD   0            ;Input  Attribute bits
DevDopenflag   DWORD   1            ;Input  open flag for KBD
DevOpenMode    DWORD   0042h        ;Input  open mode for KBD
DevExtaAttr    DWORD   0            ;Input  extended attributes for KBD

;-------------- DosDevIOCtl -------------
DevCategory    DWORD        ?        ;Input Category

;------------- Miscellaneous --------
parm1          DWORD   ?           ;handle of window sending message
parm2          DWORD   ?           ;message id value
parm3          DWORD   ?           ;message mp1
parm4          DWORD   ?           ;message mp2
textPos        DWORD   ?           ;Position of text on screen
pErrorInfo     DWORD   ?           ;address of ErrorInfo Structure
Concanted       BYTE 64 dup(0)     ;buffer to hold concanted strings

;------------ Specific to TSR Switch List use -----
DllLoadError    BYTE  100 dup(0)   ;Buffer for name of object contributing to error
DllHandle      DWORD ?             ;Handle of Dynamic LInk Module returned here
DllModuleName   BYTE  "TSR_HOOK",0 ; module name
DllProcName     BYTE  "INPUTHOOK",0 ;procedure name in dynamic link module
DllProcAddr    DWORD ?             ;address of proc in dynamic link module


.CODE

startup:                         ;need to do this way with flat model

;-----Initialize Window -Anchor block handle returned = hab
$WinInitialize 0                 ;called with argument 0
mov    hab,eax                   ;return value
.IF hab == NULL
    $DosBeep 1000,500
    $DosExit
.ENDIF

;-----Create MessageQue  QueueHandle returned = hmq
$WinCreateMsgQueue hab,0         ; 0 is default size of queue
mov      hmq,eax                 ;returned queue handle
.IF hmq == NULL
   $DosBeep 600,500
   $WinTerminate   hab
.ENDIF

;---- Register Window Class Returned value is TRUE or FALSE
$WinRegisterClass  hab,offset szAppName,offset MainWinProc,flStyle,0
mov      TorF,eax                ;return value
.IF TorF == FALSE
    $DosBeep  100,500
    $WinTerminate hab
.ENDIF

;---- CreateStandard Window - Returns handle for Main Window Frame and client Window
$WinCreateStdWindow HWND_DESKTOP,WS_VISIBLE,offset flCtlData,offset szAppName,\
                    offset szWinTitle,WS_VISIBLE,0,0,offset hwndMain
mov   hwndMainFrame,eax          ;returned Frame Window handle
.IF hwndMainFrame == 0
   $DosBeep 1000,2000
   $WinDestroyMsgQueue  hmq
   $WinTerminate hab
.ENDIF

;The way to proceed is to install a System Hook. This has to go into a
;DLL otherwise it cannot be called by other programs. The procedure in
;the tsr_hook.DLL will inspect WM_CHAR to see if the HOT key is hit and
;in the test instance will just sound an alarm or something like that to
;show it is working. In general, when it is HOOKED it will do what the
;thing is supposed to do.
;The Journal-Record hook function has the form
;  VOID APIENTRY JournalRecordHook(HAB hab, PQMSG pQmsg)
;  and does not return a value.
;  The function will test only for WM_CHAR and then do its thing.
;  It could call an application specific function in this tsr.exe
$DosLoadModule  offset DllLoadError,LENGTHOF DllLoadError,offset DllModuleName,offset DllHandle
$DosQueryProcAddr  DllHandle,1,0,offset DllProcAddr
$WinSetHook  hab,NULLHANDLE,HK_INPUT,[DllProcAddr],DllHandle

;-------- MainMessageLoop ------------
mml: $WinGetMsg hab,offset quemsg,0,0,0
     mov   TorF,eax    ;return value
     .IF TorF == TRUE
         $WinDispatchMsg hab,offset quemsg
         jmp   mml
     .ENDIF

;--------- Exit Code -------
$WinReleaseHook  hab,NULL,HK_INPUT,[DllProcAddr],DllHandle
$DosFreeModule DllHandle
$WinDestroyWindow  hwndMainFrame
$WinDestroyMsgQueue  hmq
$WinTerminate hab

;------------------ MainWinProc -----------------
;parm1 = hwnd,parm2 = msg,parm3  = mp1,parm4 = mp2
;this is called from System and so has to do everything itself
MainWinProc Proc Near
    ;----------- Get Passed Parameters from Stack ------------
    push   ebp           ;return address is 4 bytes and this push is 4 bytes
    mov    ebp,esp       ;so first parameter is 8 bytes from top
    mov    eax,[ebp+8]
    mov    parm1,eax
    mov    eax,[ebp+12]
    mov    parm2,eax
    mov    eax,[ebp+16]
    mov    parm3,eax
    mov    eax,[ebp+20]
    mov    parm4,eax

    ;---------------- WM_CREATE ----------------
    .IF parm2 == WM_CREATE
         Invoke InitMainWindow,parm1,parm3,parm4
         mov      eax,FALSE  ;return value
    .ENDIF

    ;---------------- WM_PAINT ----------------
    .IF parm2 == WM_PAINT ; && parm1 == hwndMain
       Invoke  MainPaint,parm1
       mov      eax,FALSE  ;return value
    .ENDIF

    ;---------------- WM_CHAR ----------------
   .IF parm2 == WM_CHAR
      Invoke  MainKeyboard,parm3,parm4,parm1    ;sets return value
   .ENDIF

    ;----- Default Procedure * Return Value in eax ------
    $WinDefWindowProc parm1,parm2,parm3,parm4

    ;----- Restore Stack Pointer and Stack Status
    mov      esp,ebp    ;restore  stack pointer
    pop      ebp
    ret
MainWinProc  endp

;-------------- MainPaint * WM_PAINT --------------
MainPaint  proc Near SYSCALL uses eax, var1:DWORD   ;var1 = hwnd
;-------- obtain presentation space handle
      $WinBeginPaint  var1,NULL,offset rect
      mov  hps,eax        ;returns presentation space handle
      $WinQueryWindowRect var1,offset rect
      $WinFillRect hps,offset rect,CLR_YELLOW  ;SYSCLR_WINDOW
      mov   textPos,DT_CENTER
      or    textPos,DT_WORDBREAK
      $WinDrawText  hps,-1,offset textMsg,offset rect,CLR_DARKGREEN,CLR_BLUE,TextPos  ;DT_CENTER
      .IF eax == 0
          $DosBeep 50,2000
      .ENDIF
      $WinEndPaint   hps
      $WinReleasePS hps
      ret
MainPaint  endp

;-------------- InitMainWindow * WM_CREATE --------------
;var1 = hwnd, var2 = mp1, var3 = mp2
InitMainWindow Proc Near SYSCALL, var1:DWORD,var2:DWORD,var3:DWORD

       ret
InitMainWindow Endp

;-------------- MainKeyBoard * WM_CHAR --------------
;var1 = mp1,var2 = mp2,var3 = hwnd
MainKeyBoard  Proc Near SYSCALL uses ebx ecx,var1:DWORD,var2:DWORD,var3:DWORD
      mov    ebx,mp1    ;will check for char codes
      .IF    bx & KC_CHAR   ;char code valid
          mov    ebx,mp2
         .IF    bx == 'Q'  || bx == 'q'
             $DosBeep 100,2000
         .ELSEIF  bx == 'm'  || bx == 'M'
;                  $WinErrorMessage msgboxWinChangeSwitchEntry
             $Alarm
             $WinMessageBox HWND_DESKTOP,HWND_DESKTOP,offset msgInitErr,NULL,0,msgBoxStyle
             .IF  eax == MBID_YES
                 $DosBeep  50,1000
             .ELSE
                 $DosBeep 1000,1000
             .ENDIF
         .ENDIF
          mov eax,TRUE     ;message processed
          ret
      .ENDIF
       mov    eax,FALSE    ;not processed
      ret
MainKeyBoard Endp

END   startup                    ;required

