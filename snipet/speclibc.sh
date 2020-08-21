#!/bin/sh
gcc ./test.c -o test -Wl,--rpath=$HOME/glibc_build/,--dynamic-linker=$HOME/glibc_build/elf/ld.so
