#!/bin/bash
set -e

crond -l 8 -L /root/cron.log
dnsmasq -D -u root -g root 
while true;do sleep 10;done
