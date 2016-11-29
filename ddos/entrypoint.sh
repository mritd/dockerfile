#!/bin/bash
crond -l 8 -L /root/cron.log
touch /var/log/ddos.log
tail -f /var/log/ddos.log
