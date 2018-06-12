#!/usr/bin/env bash

set -e

# Generate secret when started container
SECRET=`head -c 16 /dev/urandom | xxd -ps`

# Create 1 worker by default if MTPROXY_WORKERS is not defined
WORKERS=${MTPROXY_WORKERS:-"1"}

# Get IP for NAT mapping
PUBLIC_IP="$(curl -s https://api.ipify.org)"
INTERNAL_IP="$(ip -4 route get 8.8.8.8 | grep '^8\.8\.8\.8\s' | grep -Po 'src\s+\d+\.\d+\.\d+\.\d+' | awk '{print $2}')"

# Print secret to terminal
echo "##############################################"
echo "##                                          ##"
echo "## Secret: ${SECRET} ##"
echo "##                                          ##"
echo "##############################################"

# Always delete config!
# Because the secret may be updated, 
# the proxy address will change according to the network location
rm -f ${MTPROXY_CONFIG_PATH}/*
curl -s ${MTPROXY_SECRET_DOWNLOAD_URL} -o ${MTPROXY_CONFIG_PATH}/proxy-secret
curl -s ${MTPROXY_CONFIG_DOWNLOAD_URL} -o ${MTPROXY_CONFIG_PATH}/proxy-multi.conf

# Allow custom commands
if [ ! -z "$@" ];then
    $@
else
    mtproto-proxy \
        -u nobody \
        -p 8888 \
        -H 443 \
        -S ${SECRET} \
        -M ${WORKERS} \
        --address 0.0.0.0 \
        --nat-info "${INTERNAL_IP}:${PUBLIC_IP}" \
        --aes-pwd ${MTPROXY_CONFIG_PATH}/proxy-secret \
        ${MTPROXY_CONFIG_PATH}/proxy-multi.conf
fi
