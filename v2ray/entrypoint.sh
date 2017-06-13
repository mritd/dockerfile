#!/bin/bash

CMD=$1
CONFIG=$2

if [ "$CMD" != "" ] && [ "$CONFIG" != "" ] && [ "$CMD" == "-c" ]; then
  echo "$CONFIG" > /etc/config.json
  echo -e "\033[32mUse a custom configuration...\033[0m"
fi

v2ray -config /etc/config.json
