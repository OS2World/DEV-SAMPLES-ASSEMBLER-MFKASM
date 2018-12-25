;---------------------------------------------------------------------------;
; M.F.Kaplon  Begun:Tue  07-14-1992   RevisedFri  07-17-1992
; Title : tsr_hook.asm
;
; This is the dll to be used with tsr.asm.
; Its purpose is to test the WM_CHAR message stream from the system
; and when the HOT Key is struck to take appropriate action
;---------------------------------------------------------------------------;
;
.386             ;preceeding .MODEL makes USE32 default
.MODEL           FLAT,SYSCALL,OS_OS2

INCL_WINERRORS      equ  1
INCL_WIN            equ  1
INCL_WINSWITCHLIST  equ  1
INCLUDE         c:\toolkt20\asm\os2inc\os2def.inc ;structure defns includes POINTL
INCLUDE         c:\toolkt20\asm\os2inc\pmwin.inc  ;structure defns POINTL defn required
;INCLUDE         c:\toolkt20\asm\os2inc\pmgpi.inc  ;graphics
INCLUDE         c:\toolkt20\asm\os2inc\pmerr.inc  ;errors
INCLUDE         c:\toolkt20\asm\os2inc\pmshl.inc
INCLUDELIB      c:\toolkt20\os2lib\os2386.lib     ;Library

;INCLUDE         d:\os2_asm\equs386.inc       ;equates : MFK
INCLUDE         d:\os2_asm\386_dos.mac       ;macros using DOS calls : MFK
;INCLUDE         d:\os2_asm\386_win.mac       ;macros using WIN/GR calls :MFK

.STACK    2048

.DATA
;------------- handles --------
hk_hab            DWORD   ?    ;Anchor block Handle

;------------ structures
hk_qmsg           DWORD   ?    ;Address of Queue message structure


.CODE

; use PUBLIC rather than EXPORTS if want to pass parameters
;
;The Journal-Record hook function has the form
;  VOID APIENTRY JournalRecordHook(HAB hab, PQMSG pQmsg)

;The  Input-Hook function has the form
;  VOID APIENTRY InputHook(HAB hab, PQMSG pQmsg, ULONG fs)
;  fs can contain flags from WinPeekMsg
;  this functions returns TRUE  if message not to be passed on
;                 returns FALSE if message  is to be passed on

Inputhook  proc ;EXPORTS ; PUBLIC Using  HK_Journal Input
    ;----------- Get Passed Parameters from Stack ------------
    push   ebp           ;return address is 4 bytes and this push is 4 bytes
    mov    ebp,esp       ;so first parameter is 8 bytes from top
    mov    eax,[ebp+8]
    mov    hk_hab,eax      ;anchor block handle
    mov    eax,[ebp+12]
    mov    hk_qmsg,eax     ;address of message structure
    mov    esi,hk_qmsg
    mov    ebx,[esi+4]       ;message
    .IF    ebx == WM_CHAR
         mov    ebx,[esi+8]     ;mp1 will check for char codes
         mov    cx,KC_ALT       ;Alt Key was down when
         add    cx,KC_CHAR      ;this key pressed
         and    bx,cx
        .IF    bx               ;Alt Key down and Char Key hit
            mov    ebx,[esi+12]  ;mp2 low order  16 bits has char
           .IF    bx == '1'
               $DosBeep 1000,2000
           .ENDIF
        .ENDIF
    .ENDIF
    mov    esp,ebp       ;restore  stack pointer
    pop    ebp           ;back to  way it was at entrance
    mov    eax,FALSE     ;Return Value = pass on to chain
    ret
Inputhook endp


JournalRecordHook  proc
    ret
JournalRecordHook  endp

END




