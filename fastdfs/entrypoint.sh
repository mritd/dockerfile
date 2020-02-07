#!/usr/bin/env bash

MODE=$1

if [ "${MODE}" == "trackerd" ];then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] INFO: container run as trackerd mode."
    /etc/init.d/fdfs_trackerd start
    while true;do
        if [ ! -n "$(ps -ef | grep fdfs_trackerd | grep -v grep)" ];then
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: fdfs health check failed, container exit!"
            exit 1
        fi
        sleep 1
    done
elif [ "${MODE}" == "storaged" ];then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] INFO: container run as storaged mode."
    /etc/init.d/fdfs_storaged start
    while true;do
        if [ ! -n "$(ps -ef | grep fdfs_storaged | grep -v grep)" ];then
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: fdfs health check failed, container exit!"
            exit 1
        fi
        sleep 1
    done
else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] INFO: container run as test mode."
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] WARN: fastdfs container must use host network mode."

    if [ ! -n "${PUBIP}" ];then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: Environment variable \"PUBIP\" is not set!"
        exit 1
    fi
    
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] INFO: use ${PUBIP} as fastdfs ip."
    sed -i "s@{{TRACKER_IP}}@${PUBIP}@g" /etc/fdfs/*.conf

    /etc/init.d/fdfs_trackerd start
    /etc/init.d/fdfs_storaged start

    while true;do
        if [ ! -n "$(ps -ef | grep fdfs_trackerd | grep -v grep)" ] || \
            [ ! -n "$(ps -ef | grep fdfs_storaged | grep -v grep)" ];then
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: fdfs health check failed, container exit!"
            exit 1
        fi
        sleep 1
    done
fi
