#!/bin/bash

mkdir -p /usr/share/nginx/html/centos/7.2/{i386,x86_64,noarch,updates,SRPMS}
cd /usr/share/nginx/html/centos/7.2/ && ls | xargs -i createrepo {} 
crond
nginx -g daemon off;
