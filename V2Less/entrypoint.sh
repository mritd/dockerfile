#!/bin/bash

CMD=$1
CONFIG=$2

if [ "$CONFIG" != "" ] && [ "$CMD" == "-c" ]; then
  echo "$CONFIG" > /etc/v2ray/config.json
  echo -e "\033[32mUse a custom configuration...\033[0m"
fi

if [ "$CMD" != "" ] && [ "$CMD" != "-c" ]; then
  $*
else
  v2ray -config /etc/v2ray/config.json
fi
