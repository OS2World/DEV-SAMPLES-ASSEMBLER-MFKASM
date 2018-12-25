ml /c d:\os2_asm\%1.asm
IF errorlevel 1 goto errexit
rem link /MAP /LINE /PM:VIO /ALIGN:16 /E %1.obj ;
link  /PM:VIO /ALIGN:16 /E %1.obj ;
del *.obj
quit
:errexit
Echo Compile Error - NO Link

