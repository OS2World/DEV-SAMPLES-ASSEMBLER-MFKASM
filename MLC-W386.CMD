ml /c d:\os2_asm\%1.asm
IF errorlevel 1  goto errexit
rem link386 /PM:PM /ALIGN:16 /E /BASE:0x10000 %1.obj ;
link386 /PM:PM /ALIGN:16 /E %1.obj;,,d:\os2_asm\%1.def ;
del *.obj
del *.map
quit
:errexit
Echo Compile Error NO Link
