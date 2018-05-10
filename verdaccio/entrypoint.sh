#!/bin/bash
set -e

chown -R verdaccio:verdaccio /verdaccio

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
    set -- verdaccio "$@"
fi

# Run as user "verdaccio" if the command is "verdaccio"
# allow the container to be started with `--user`
if [ "$1" = 'verdaccio' -a "$(id -u)" = '0' ]; then
    set -- su-exec verdaccio "$@"
fi

exec "$@"
