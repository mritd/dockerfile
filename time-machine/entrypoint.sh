#!/bin/bash

USER_NAME=${USER_NAME:-"mritd"}
USER_ID=${USER_ID:-"1000"}
PASSWORD=${PASSWORD:-"123456"}
MOUNT_POINT=${MOUNT_POINT-"/data"}
VOL_SIZE_MB=${VOL_SIZE_MB-"512000"}

while getopts "u:i:p:m:v" OPT; do
    case $OPT in
        u)
            USER_NAME=$OPTARG;;
        i)
            USER_ID=$OPTARG;;
        p)
            PASSWORD=$OPTARG;;
        m)
            MOUNT_POINT=$OPTARG;;
        v)
            VOL_SIZE_MB=$OPTARG;;
    esac
done

cat /etc/passwd | grep ${USER_NAME} >& /dev/null

if [ $? -ne 0 ];then
    echo "Add user: ${USER_NAME}..."
    adduser -S -H -G root ${USER_NAME} -u ${USER_ID}
    echo ${USER_NAME}:${PASSWORD} | chpasswd &> /dev/null
else
    echo "User: ${USER_NAME} already exists!"
fi

mkdir -p ${MOUNT_POINT}
chown -R ${USER_NAME}:root ${MOUNT_POINT}

cat /etc/afp.conf | grep "${USER_NAME}" >& /dev/null

if [ $? -ne 0 ];then
    echo "Update /etc/afp.conf..."
    cat << EOF >> /etc/afp.conf
[${USER_NAME}]
valid users = ${USER_NAME}
path = ${MOUNT_POINT}
time machine = yes
vol size limit = ${VOL_SIZE_MB}
EOF
else
    echo "afp.conf already modify!"
fi

echo "Starting..."

if [ -e /var/run/dbus.pid ]; then
    rm -f /var/run/dbus.pid
fi

if [ -e /var/run/dbus/system_bus_socket ]; then
	rm -f /var/run/dbus/system_bus_socket
fi

dbus-daemon --system

runsvdir /etc/runit/services
