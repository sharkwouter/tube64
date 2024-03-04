#!/bin/bash

clear

#if false; then

rm -f *.o
rm -f *.map
rm -f bin/tube64
rm -f bin/EBOOT.PBP
rm -f bin/PARAM.SFO

#echo 'Press any key...'
#read -rsn1

echo 'Compile tube...'
psp-g++ -Ofast -DNDEBUG -ffunction-sections -fdata-sections -fno-rtti -ftree-vectorize -fno-math-errno -fmax-errors=1 -fomit-frame-pointer -ffast-math -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables -Wall -Wno-unused-variable -Wno-unused-but-set-variable -Wno-parentheses -Wno-maybe-uninitialized -Wno-unused-result -Wno-format-security -c Game/tube.cpp -IGame -IMusic -ISound -Itlsf -fsigned-char
psp-g++ -Ofast -DNDEBUG -ffunction-sections -fdata-sections -fno-rtti -ftree-vectorize -fno-math-errno -fmax-errors=1 -fomit-frame-pointer -ffast-math -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables -Wall -Wno-unused-variable -Wno-unused-but-set-variable -Wno-parentheses -Wno-maybe-uninitialized -Wno-unused-result                      -c Game/trig.cpp -IGame -IMusic -ISound -Itlsf
psp-g++ -Ofast -DNDEBUG -ffunction-sections -fdata-sections -fno-rtti -ftree-vectorize -fno-math-errno -fmax-errors=1 -fomit-frame-pointer -ffast-math -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables -Wall -Wno-unused-variable -Wno-unused-but-set-variable -Wno-parentheses -Wno-maybe-uninitialized -Wno-unused-result                      -c Game/misc.cpp -IGame -IMusic -ISound -Itlsf

psp-g++ -Ofast -DNDEBUG -ffunction-sections -fdata-sections -fno-rtti -ftree-vectorize -fno-math-errno -fmax-errors=1 -fomit-frame-pointer -ffast-math -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables -Wall -Wno-unused-variable -Wno-unused-but-set-variable -Wno-parentheses -Wno-maybe-uninitialized -Wno-unused-result -D_OPL3_ -c Music/HMP.cpp  -IGame -IMusic -ISound -Itlsf
psp-g++ -Ofast -DNDEBUG -ffunction-sections -fdata-sections -fno-rtti -ftree-vectorize -fno-math-errno -fmax-errors=1 -fomit-frame-pointer -ffast-math -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables -Wall -Wno-unused-variable -Wno-unused-but-set-variable -Wno-parentheses -Wno-maybe-uninitialized -Wno-unused-result -D_OPL3_ -c Sound/SB16.cpp -IGame -IMusic -ISound -Itlsf

psp-gcc -Ofast -DNDEBUG -ffunction-sections -fdata-sections           -ftree-vectorize -fno-math-errno -fmax-errors=1 -fomit-frame-pointer -ffast-math -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables -Wall -Wno-unused-variable -Wno-unused-but-set-variable -Wno-parentheses -Wno-maybe-uninitialized -Wno-unused-result -c Music/hmpfile.c       -IGame -IMusic -ISound -Itlsf
psp-gcc -Ofast -DNDEBUG -ffunction-sections -fdata-sections           -ftree-vectorize -fno-math-errno -fmax-errors=1 -fomit-frame-pointer -ffast-math -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables -Wall -Wno-unused-variable -Wno-unused-but-set-variable -Wno-parentheses -Wno-maybe-uninitialized -Wno-unused-result -c Music/hmpopl.c        -IGame -IMusic -ISound -Itlsf
psp-gcc -Ofast -DNDEBUG -ffunction-sections -fdata-sections           -ftree-vectorize -fno-math-errno -fmax-errors=1 -fomit-frame-pointer -ffast-math -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables -Wall -Wno-unused-variable -Wno-unused-but-set-variable -Wno-parentheses -Wno-maybe-uninitialized -Wno-unused-result -c Music/opl3.c -o opl.o -IGame -IMusic -ISound -Itlsf

psp-gcc -Ofast -DNDEBUG -ffunction-sections -fdata-sections           -ftree-vectorize -fno-math-errno -fmax-errors=1 -fomit-frame-pointer -ffast-math -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables -Wall -Wno-unused-variable -Wno-unused-but-set-variable -Wno-parentheses -Wno-maybe-uninitialized -Wno-unused-result -c tlsf/tlsf.c
psp-g++ -Ofast -DNDEBUG -ffunction-sections -fdata-sections -fno-rtti -ftree-vectorize -fno-math-errno -fmax-errors=1 -fomit-frame-pointer -ffast-math -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables -Wall -Wno-unused-variable -Wno-unused-but-set-variable -Wno-parentheses -Wno-maybe-uninitialized -Wno-unused-result -c tlsf/allocator.cpp

#fi

echo 'Link tube...'
psp-g++  -Ofast -DNDEBUG -o bin/tube64 tube.o trig.o misc.o opl.o hmpopl.o hmpfile.o HMP.o SB16.o tlsf.o allocator.o $(psp-pkg-config --libs --cflags sdl2) -I$(psp-config --pspsdk-path)/include -L$(psp-config --pspsdk-path)/lib  -Xlinker -Map=tube.map -Wl,--strip-all -Wl,--gc-sections

psp-strip bin/tube64
psp-fixup-imports bin/tube64
mksfoex -d "MEMSIZE=1" -s "APP_VER=1.0" Tube64 bin/PARAM.SFO
pack-pbp bin/EBOOT.PBP bin/PARAM.SFO NULL NULL NULL NULL NULL bin/tube64 NULL