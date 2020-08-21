#!/bin/sh

sudo btmgmt -i $1 power off
sudo btmgmt -i $1 le on
sudo btmgmt -i $1 connectable on
sudo btmgmt -i $1 discov yes
#sudo btmgmt -i $2 bondable off
sudo btmgmt -i $1 pairable on
sudo btmgmt -i $1 advertising on
sudo btmgmt -i $1 power on
