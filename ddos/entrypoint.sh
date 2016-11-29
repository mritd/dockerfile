#!/bin/bash
crond -l 8 -L /root/cron.log
python -m SimpleHTTPServer
