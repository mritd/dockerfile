#!/bin/bash

SS_CONFIG=${SS_CONFIG:-""}
SS_MODULE=${SS_MODULE:-"ss-server"}
KCP_CONFIG=${KCP_CONFIG:-""}
KCP_MODULE=${KCP_MODULE:-"kcpserver"}
KCP_FLAG=${KCP_FLAG:-"false"}
LOG_FILE=${LOG_FILE:-"/dev/stdout"}

while getopts "s:m:k:e:o:x" OPT; do
    case $OPT in
        s)
            SS_CONFIG=$OPTARG;;
        m)
            SS_MODULE=$OPTARG;;
        k)
            KCP_CONFIG=$OPTARG;;
        e)
            KCP_MODULE=$OPTARG;;
        o)
            LOG_FILE=$OPTARG;;
        x)
            KCP_FLAG="true";;
    esac
done

export SS_CONFIG=${SS_CONFIG}
export SS_MODULE=${SS_MODULE}
export KCP_CONFIG=${KCP_CONFIG}
export KCP_MODULE=${KCP_MODULE}
export LOG_FILE=${LOG_FILE}
export KCP_FLAG=${KCP_FLAG}

exec runsvdir -P /etc/service
