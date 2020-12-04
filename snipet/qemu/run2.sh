#!/bin/sh
./qemu-system-x86_64 -m 9216 --enable-kvm -s -smp 2 -k "en-us" /home/wataru/Documents/virt-img/testimg-ubuntu-20.04.1-desktop.qcow2 -nic model=e1000 -d int
