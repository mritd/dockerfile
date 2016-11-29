#!/bin/bash
crond -l 8 -L /root/cron.log
tail -f /var/log/ddos.log
