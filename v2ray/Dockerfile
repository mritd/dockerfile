FROM alpine:3.4

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

WORKDIR /root

RUN apk upgrade --update && \
    apk add --update bash tzdata curl && \
    mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    VERSION="$(curl -s https://api.github.com/repos/v2ray/v2ray-core/releases/latest | grep 'tag_name' | cut -d\" -f4)" && \
    DOWNLOAD_URL="https://github.com/v2ray/v2ray-core/releases/download/${VERSION}/v2ray-linux-64.zip" && \
    curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip ${DOWNLOAD_URL} && \
    unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray/ && \
    mkdir -p /var/log/v2ray /usr/bin/v2ray && \
    cp /tmp/v2ray/v2ray-${VERSION}-linux-64/v2ray /usr/bin/v2ray/v2ray && \
    chmod +x /usr/bin/v2ray/v2ray && \
    cp /tmp/v2ray/v2ray-${VERSION}-linux-64/vpoint_vmess_freedom.json /etc/v2ray/config.json && \
    let PORT=$RANDOM+10000 && sed -i "s/10086/${PORT}/g" /etc/v2ray/config.json && \
    UUID=$(cat /proc/sys/kernel/random/uuid) && sed -i "s/23ad6b10-8d1a-40f7-8ad0-e3e35cd38297/${UUID}/g" /etc/v2ray/config.json && \
    echo "PORT:${PORT}" && echo "UUID:${UUID}" && \
    rm -rf /tmp/v2ray/* && \
    rm -rf /var/cache/apk/*

ADD entrypoint.sh /root/entrypoint.sh

CMD ["/bin/bash"]
