#!/bin/sh
sudo clamdscan | tee ~/clamav_log/log_$(date +%2F).txt
