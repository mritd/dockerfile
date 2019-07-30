#!/bin/bash

set -e

cd /app

INIT_FILE=/data/init

if [ ! -f "${INIT_FILE}" ]; then
    node scripts/init
    touch "${INIT_FILE}"
fi

node dispatch.js
