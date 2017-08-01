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
    chown -R elasticsearch:elasticsearch "${ELASTICSEARCH_HOME}" /data/elasticsearch /var/log/elasticsearch

    #exec su-exec elasticsearch "$BASH_SOURCE" "$@"
    set -- su-exec elasticsearch "$@"
fi

# As argument is not related to elasticsearch,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"
