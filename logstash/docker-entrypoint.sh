#!/bin/bash

set -e

env2yaml ${LOGSTASH_HOME}/config/logstash.yml

chown -R logstash:logstash /data /var/log/logstash 

if [[ -z $1 ]] || [[ ${1:0:1} == '-' ]] ; then
  	exec logstash "$@"
else
  	exec "$@"
fi
