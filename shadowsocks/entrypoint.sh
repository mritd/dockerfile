#!/bin/bash

SERVER_ADDR=0.0.0.0
SERVER_PORT=5000
PASSWORD=ZQoPF2g6uwJE7cy4
METHOD=aes-256-cfb
TIMEOUT=300
ONE_TIME_AUTH=""
FAST_OPEN=""
WORKERS=1
PREFER_IPV6="--prefer-ipv6"

while getopts "s:p:k:m:t:w:af" OPT; do
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
    w)
        WORKERS=$OPTARG;;
    a)
        ONE_TIME_AUTH="-a";;
    f)
        FAST_OPEN="--fast-open";;
  esac
done

/usr/bin/ssserver -s $SERVER_ADDR -p $SERVER_PORT -k $PASSWORD -m $METHOD -t $TIMEOUT -w $WORKERS $ONE_TIME_AUTH $FAST_OPEN $PREFER_IPV6
