#!/bin/sh
echo "Should be execute in root of buildroot"
echo "kernel config should support 9p_virtio"
$1 -M pc -kernel output/images/bzImage -drive file=output/images/rootfs.ext2,if=virtio,format=raw -append "nographic rootwait root=/dev/vda console=tty1 console=ttyS0 nokaslr" -serial stdio -net nic,model=virtio -net user  -smp 2 -s -nic model=e1000, -fsdev  local,id=test_dev,path=/home/wataru/vmshare,security_model=none -device virtio-9p-pci,fsdev=test_dev,mount_tag=test_mount
