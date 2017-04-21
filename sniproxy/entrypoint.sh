#!/bin/sh
set -e

if [ -n "$1" ];then
    exec sniproxy "$@"
else
    exec sniproxy -f -c /etc/sniproxy.conf
fi
