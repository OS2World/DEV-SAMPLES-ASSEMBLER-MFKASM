ml /c d:\os2_asm\%1.asm
IF errorlevel 1  goto errexit
link386 /PM:PM /ALIGN:16 /E %1.obj ;
del *.obj
quit
:errexit
Echo Compile Error NO Link
