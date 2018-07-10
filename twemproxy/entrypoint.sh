#!/bin/bash

set -e

if [ -z "$1" ]; then
    exec nutcracker -c ${TWEMPROXY_CONFIG_DIR}/config.yml
else
    exec "$@"
fi
