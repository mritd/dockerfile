#!/bin/bash

SERVER_ADDR=0.0.0.0
SERVER_PORT=5000
PASSWORD=ZQoPF2g6uwJE7cy4
METHOD=aes-256-cfb
TIMEOUT=300
ONE_TIME_AUTH=""
FAST-OPEN=""
WORKERS=""
PREFER-IPV6="--prefer-ipv6"

while getopts "s:p:k:m:t:a" OPT; do
  case $OPT in
    s)
        SERVER_ADDR=$OPTARG;;
    p)
        SERVER_PORT=$OPTARG;;
    k)
        PASSWORD=$OPTARG;;
    m)
        METHOD=$OPTARG;;
    t)
        TIMEOUT=$OPTARG;;
    a)
        ONE_TIME_AUTH="-a";;
  esac
done

/usr/bin/ssserver -s $SERVER_ADDR -p $SERVER_PORT -k $PASSWORD -m $METHOD -t $TIMEOUT $ONE_TIME_AUTH
