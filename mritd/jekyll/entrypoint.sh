#!/bin/bash

crond -l 8 -L /root/cron.log
cd /root/mritd.github.io
jekyll serve -H mritd.me -P 80 -w
