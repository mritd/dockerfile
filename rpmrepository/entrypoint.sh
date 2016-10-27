#!/bin/bash

mkdir -p /data/repo/centos/7/{i386,x86_64,noarch,updates,SRPMS}
cd /data/repo/centos/7/ && ls | xargs -i createrepo {}
crond
nginx -g "daemon off;"
