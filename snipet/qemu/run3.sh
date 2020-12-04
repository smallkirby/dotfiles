#!/bin/sh
if [ -z "$1" ];
then
  echo "specify kernel image"
  exit
fi
if [ -z "$2" ];
then
  echo "specify ramfs image"
  exit
fi
mkinitramfs -o ramdisk.img
./qemu-system-x86_64 -m 9216 --enable-kvm -s -smp 2 -k "en-us"  -nic model=e1000 -d int -kernel $1 -nographic -append "console=ttyS0" -append nokaslr -initrd $2
