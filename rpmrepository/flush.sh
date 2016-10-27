#!/bin/bash
cd /usr/share/nginx/html/centos/7.2/ && ls | xargs -i createrepo --update {}
