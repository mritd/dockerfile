#!/bin/bash

crond -l 8 -L /root/cron.log
jekyll serve -H 0.0.0.0 -P 80
