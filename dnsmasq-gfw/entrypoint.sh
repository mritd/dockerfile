#!/bin/bash
set -e

crond -l 8 -L /var/log/cron.log
dnsmasq -D -u root -g root 
while true;do sleep 10;done
