#!/bin/bash

if [ "${SS_CONFIG}" != "" ]; then
    shadowsocks -s ${SS_CONFIG} -verbose
else
    shadowsocks $@
fi
