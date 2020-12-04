#!/bin/sh

sudo btmgmt -i $1 power off
sudo btmgmt -i $1 le on
sudo btmgmt -i $1 connectable on
sudo btmgmt -i $1 discov yes
sudo btmgmt -i $1 sc off
sudo btmgmt -i $1 bondable off
sudo btmgmt -i $1 pairable on
sudo btmgmt -i $1 clr-devices
sudo btmgmt -i $1 io-cap 3 # noinputoutput
sudo btmgmt -i $1 advertising off
sudo btmgmt -i $1 power on
