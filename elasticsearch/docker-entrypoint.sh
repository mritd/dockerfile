#!/bin/bash

set -e

# Add elasticsearch as command if needed
if [ "${1:0:1}" = '-' ]; then
    set -- elasticsearch "$@"
fi

# Drop root privileges if we are running elasticsearch
# allow the container to be started with `--user`
if [ "$1" = 'elasticsearch' -a "$(id -u)" = '0' ]; then
    # Change the ownership of user-mutable directories to elasticsearch
    for path in \
        /usr/share/elasticsearch/data \
        /usr/share/elasticsearch/logs \
    ; do
        chown -R elasticsearch:elasticsearch "$path"
    done
    
    set -- su-exec elasticsearch "$@"
    #exec su-exec elasticsearch "$BASH_SOURCE" "$@"
fi

# As argument is not related to elasticsearch,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"
