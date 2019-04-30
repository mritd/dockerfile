#!/bin/sh

if [ "${SS_CONFIG}" != "" ]; then
    exec shadowsocks -s ${SS_CONFIG} -verbose
else
    exec shadowsocks $@
fi
