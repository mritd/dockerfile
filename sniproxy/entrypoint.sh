#!/bin/sh
set -e

if [ ! -n "$1" ];do
    exec sniproxy "$@"
else
    exec sniproxy -c /etc/sniproxy.conf
fi
