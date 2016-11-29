#!/bin/bash
crond -l 8 -L /root/cron.log
nohup python -m SimpleHTTPServer &
