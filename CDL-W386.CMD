rem make libary
implib c:\toolkt20\os2lib\%1.lib d:\os2_src\%1.def
If errorlevel 1  goto errexit0
rem compile dll program
icc /C+ /Ge- d:\os2_src\%1.c
IF errorlevel 1  goto errexit1
link386 /PM:PM /ALIGN:16 /E %1.obj,,,c:\toolkt20\os2lib\%1.lib, d:\os2_src\%1.def ;
If errorlevel  1 goto errexit2
del *.obj
goto exit
:errexit0
Echo Error making ImpLib Library file
goto exit
:errexit1
Echo Compile Error NOT Linking for DLL
goto exit
:errexit2
Echo Link Error for DLL
:exit
Echo DLL Compile and Link OK
move c:\%1.dll c:\os2\dll

