Morton F. Kaplon CIS:73457,437
1047 Johnston Drive
Bethlehem PA 18017
(215)758-9686
Tue  08-04-1992

The files included here represent my effort in utilizing Assembler for
programming in OS/2 2.0 .

I use MASM 6.0 as the Assembler and I can highly recommend it. It has
some very useful constructs which make programming in Assembler almost
as easy as using "C", I think. Perhaps in some cases even easier since
I believe the use of Pointers in Assembler is much clearer than in
C, especially if they are several levels deep.

The files included are listed below, each with a brief explanation

286_dos.mac    Macros used for ASM files using OS2286.LIB
386_dos.mac    Macros used for ASM files using OS2386.LIB and DOS... calls
386_win.mac    Macros used for ASM files using OS2386.LIB and WIN... calls
ccl-w386.cmd   Cmd file used for assembling and linking for PM programs
cdl-w386.cmd   Cmd file used for creating a DLL for PM programs
equates.inc    Equates required for 16 bit programs.
equs386.inc    Equates required for 32 bit programs.
get-cmd.asm    32 bit program demonstrating accessing Command Line
get-cmd.exe    Executable for above
gethotky.asm   32 bit program getting info on Session Manager Hot Keys
gethotky.exe   Executable for above
kb-rate.asm    32 bit program to set Keyboard rates
kb-rate.exe    Executable for above
mlc-l286.cmd   Command file for assembling-linking 16 bit programs
mlc-l386.cmd   Command file for assembling-linking 32 bit VIO programs
mlc-w386.cmd   Command file for assembling-linking 32 bit PM programs
mlcal286.cmd   As mlc-l286.cmd but with MAP and LINE options on
mlp-l386.cmd   Command file for assembling-linking 32 bit PM programs
pm-tmplt.asm   32 bit program illustrating PM and setting HOOK into dll
pm-tmplt.exe   Executable for above
readme.doc     This document
shutdown.asm   16 bit program to shutdown system from command line
shutdown.exe   Executable for above
tsr_hook.asm   32 code for creating a dll for use with pm-tmplt
tsr_hook.def   definition file for above
tsr_hook.dll   dll created for;!! above must be in \os2\dll

The *.cmd files are intended to make assembling and linking easy. They
are created in consonance with my set-up which has my ASM source files
on my D: drive  in a directory \os2_asm

One uses the appropriate CMD file with the source file as its target
without any extension.

Crucial to the effort are the *.mac files which contain a variety of MACROS.
All MACROS begin with a "$" and when calling a  system function use the same
name. In addition to MACROS for the various system calls, they contain also
some macros called  $PRINTF which are intended to be "sort of like" the
printf function in "C". Their use is documented in the files.

The macros contain some ASCII <--> Numerical conversion routines for
unsigned integers.

I have added to the Library (and made changes in its concept ) as I required
additional calls to OS/2 functions. Thus they are far from complete and
there may also be ( Iam sure ) some inconsistencies in format.

Since I started with OS/2  1.3  and MASM (which had a 1.3 DOS library)
I had to make changes in  moving to OS/2 2.0.

Note in particular that the MACROS calling functions using the 286
library are quite different than those using the 386 library. The former
uses the PASCAL convention and the latter the C convention which are
required for the libraries IBM supplied.

I would appreciate any comment and/or feedback.

Morton F. Kaplon

