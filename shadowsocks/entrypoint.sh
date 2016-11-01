#!/bin/bash

SERVER_ADDR=${SERVER_ADDR:-0.0.0.0}
SERVER_PORT=${SERVER_PORT:-5000}
PASSWORD=${PASSWORD-:ZQoPF2g6uwJE7cy4}
METHOD=${METHOD:-aes-256-cfb}
TIMEOUT=${TIMEOUT:-300}
ONE_TIME_AUTH=${ONE_TIME_AUTH:-""}
FAST_OPEN=${FAST_OPEN:-""}
WORKERS=${WORKERS:-1}
PREFER_IPV6=${PREFER_IPV6:-""}
KCPTUN_FLAG=${KCPTUN_FLAG:-"true"}
KCPTUN_CONFIG=${KCPTUN_CONFIG:-""}

while getopts "s:p:k:m:t:w:c:afx" OPT; do
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
    c)
        KCPTUN_CONFIG=$OPTARG;;
    a)
        ONE_TIME_AUTH="-a";;
    f)
        FAST_OPEN="--fast-open";;
    i)
        PREFER_IPV6="--prefer-ipv6";;
    x)
        KCPTUN_FLAG="false";;

  esac
done

if [ "$KCPTUN_FLAG" == "true" ]; then
  echo -e "\033[32mStarting kcptun......\033[0m"
  if [ "$KCPTUN_CONFIG" != "" ]; then
    echo -e "\033[32mOverride the kcptun configuration......\033[0m"
    echo "$KCPTUN_CONFIG" > /etc/kcptun.cfg
  fi
  kcptun -c /etc/kcptun.cfg 2>&1 &
else
  echo -e "\033[33mKcptun not started......\033[0m"
fi

echo -e "\033[32mStarting shadowsocks......\033[0m"
/usr/bin/ssserver -s $SERVER_ADDR -p $SERVER_PORT -k "$PASSWORD" -m $METHOD -t $TIMEOUT \
                  --workers $WORKERS $ONE_TIME_AUTH $FAST_OPEN $PREFER_IPV6
