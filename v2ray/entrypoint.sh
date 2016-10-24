#!/bin/bash

CMD=$1
CONFIG=$2

if [ "$CMD" != "" ] && [ "$CONFIG" != "" ] && [ "$CMD" == "-c" ]; then
  echo "$CONFIG" > /root/config.json
  echo -e "\033[32mUse a custom configuration...\033[0m"
fi

/root/v2ray -config /root/config.json
