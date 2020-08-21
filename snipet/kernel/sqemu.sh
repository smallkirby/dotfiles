# Use "mkinitramfs -o ramdisk.img" for creating new initramfs

KERNEL=$1
INITRD=$2

qemu-system-x86_64 -kernel $KERNEL -nographic -append "console=ttyS0" -initrd $INITRD -m 512 --enable-kvm -s
