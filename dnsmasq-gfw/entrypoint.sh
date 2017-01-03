#!/bin/bash
set -e

crond -l 8 -L /root/cron.log
dnsmasq -k
