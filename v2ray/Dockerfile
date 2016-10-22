FROM alpine:3.4

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

WORKDIR /root

RUN apk upgrade --update && \
    apk add --update bash tzdata wget && \
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
    rm -rf /tmp/v2ray/* && \
    rm -rf /var/cache/apk/*


CMD ["/bin/bash"]
