#!/bin/bash

USERNAME=${USERNAME:-"mritd"}
PASSWORD=${PASSWORD:-"123456"}
MOUNT_POINT=${MOUNT_POINT-"/data"}
VOL_SIZE_MB=${VOL_SIZE_MB-"512000"}

while getopts "u:p:m:v" OPT; do
    case $OPT in
        u)
            USERNAME=$OPTARG;;
        p)
            PASSWORD=$OPTARG;;
        m)
            MOUNT_POINT=$OPTARG;;
        v)
            VOL_SIZE_MB=$OPTARG;;
    esac
done

cat /etc/passwd | grep $USERNAME >& /dev/null

if [ $? -ne 0 ];then
    echo "Add user: $USERNAME..."
    adduser -S -H -G root $USERNAME
    echo ${USERNAME}:${PASSWORD} | chpasswd &> /dev/null

else
    echo "User: $USERNAME already exists!"
fi

mkdir -p $MOUNT_POINT
chown -R $USERNAME:root $MOUNT_POINT

cat /etc/afp.conf | grep "$USERNAME" >& /dev/null

if [ $? -ne 0 ];then
    echo "Update /etc/afp.conf..."
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

echo "Starting..."

if [ -e /var/run/dbus.pid ]; then
    rm -f /var/run/dbus.pid
fi

if [ -e /var/run/dbus/system_bus_socket ]; then
	rm -f /var/run/dbus/system_bus_socket
fi

dbus-daemon --system

runsvdir /etc/runit/services
