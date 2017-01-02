#!/bin/sh
set -e

if [ ! -n "$1" ];then
    exec sniproxy "$@"
else
    exec sniproxy -c /etc/sniproxy.conf
fi
