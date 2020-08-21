#!/bin/sh
qemu-system-x86_64 -enable-kvm -m 4096 ./testimg-ubuntu18.04-server-01.qcow2 -s -smp 2
