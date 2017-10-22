#!/bin/bash

LIGHT_MODULE=${LIGHT_MODULE:-"lightsocks-server"}

if [ "$1" != "" ]; then
    exec "$@"
else
    $LIGHT_MODULE
fi
