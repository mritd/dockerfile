#/bin/bash

for dir in /data/{data,logs,config,plugins,client-plugins}; do
    if [ ! -d "${dir}" ]; then
        mkdir -p ${dir}
    fi
done

exec $@
