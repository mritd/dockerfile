#!/bin/bash

CMD=$1
CONFIG=$2

if [ "$CMD" != "" ] && [ "$CONFIG" != "" ] && [ "$CMD" == "-c" ]; then
  echo "$CONFIG" > /etc/v2ray/config.json
  echo -e "\033[32mUse a custom configuration...\033[0m"
elif [ "$CMD" != "" ] && [ "$CMD" != "-c" ]; then
  $*
else
  v2ray -config /etc/v2ray/config.json
fi
