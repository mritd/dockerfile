#!/bin/bash
set -e

chown -R logstash:logstash /data /var/log/logstash 

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
    set -- logstash "$@"
fi

# Run as user "logstash" if the command is "logstash"
# allow the container to be started with `--user`
if [ "$1" = 'logstash' -a "$(id -u)" = '0' ]; then
    set -- su-exec logstash "$@"
fi

exec "$@"
