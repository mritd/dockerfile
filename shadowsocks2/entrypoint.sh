#!/bin/bash

SS_CONFIG=${SS_CONFIG:-""}

while getopts ":s:" OPT; do
    case $OPT in
        s)
            SS_CONFIG=$OPTARG;;
    esac
done

if [ "${SS_CONFIG}" != "" ]; then
    echo -e "\033[32mStarting shadowsocks......\033[0m"
    shadowsocks -s ${SS_CONFIG} -verbose
else
    shadowsocks $@
fi
