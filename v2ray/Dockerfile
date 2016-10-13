FROM alpine:3.4

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --update && \
    apk add --update bash tzdata wget && \
    wget --no-check-certificate https://github.com/v2ray/v2ray-core/releases/download/v2.2.1/v2ray-linux-64.zip && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    rm -rf /var/cache/apk/*

CMD ["/bin/bash"]
