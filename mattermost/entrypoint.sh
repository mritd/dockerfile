#/bin/bash

for dir in /data/data /data/logs /data/config /data/plugins /data/client-plugins; do
    if [ ! -d "${dir}" ]; then
        mkdir -p ${dir}
    fi
done

exec $@
