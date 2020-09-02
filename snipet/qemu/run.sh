#!/bin/sh
./qemu-system-x86_64 -enable-kvm -m 9216 -s -smp 2 -k "en-us" -nic model=e1000 -nokaslr /home/wataru/Documents/virt-img/testimg-ubuntu-20.04.1-desktop.qcow2 -d -monitor stdio
