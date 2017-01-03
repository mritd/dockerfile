#!/bin/bash
set -e

crond -l 8 -L /var/log/cron.log
dnsmasq -k
