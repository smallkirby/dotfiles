#!/bin/sh
mkdir -p ./bin/debug/native
./configure --enable-debug --target-list=x86_64-softmmu --prefix=/usr --disable-werror --enable-debug-info --enable-debug-tcg --enable-kvm
