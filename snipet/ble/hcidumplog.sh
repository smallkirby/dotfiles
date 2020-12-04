#!/bin/sh
if [ -z "$1" ];
then
  echo "specify hci number"
  exit
fi
name=$2
if [ -z "$2" ];
then
  echo "output filename is set as 'hogehoge.hcilog'"
  name="hogehoge.hcilog"
fi
sudo hcidump -i hci$1 | tee $name | less
