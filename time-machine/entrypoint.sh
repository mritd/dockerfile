#!/bin/bash

USERNAME=${USERNAME:-"mritd"}
PASSWORD=${PASSWORD:-"123456"}
MOUNT_POINT=${MOUNT_POINT-"/data"}
VOL_SIZE_MB=${VOL_SIZE_MB-"512000"}

cat /etc/passwd | grep $USERNAME >& /dev/null

if [ $? -ne 0 ];then
    adduser -S -H -G root $USERNAME
else
    echo "User: $USERNAME already exists!"
fi

mkdir -p $MOUNT_POINT
chown -R $USERNAME:root $MOUNT_POINT

cat /etc/afp.conf | grep "$USERNAME" >& /dev/null

if [ $? -ne 0 ];then
    cat << EOF >> /etc/afp.conf
[$USERNAME]
valid users = $USERNAME
path = $MOUNT_POINT
time machine = yes
vol size limit = $VOL_SIZE_MB
EOF
else
    echo "afp.conf already modify!"
fi

if [ ! -e /var/run/dbus/system_bus_socket ]; then
    dbus-daemon --system
fi

netatalk -d
