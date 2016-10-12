FROM alpine:3.4

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

WORKDIR /root

RUN apk upgrade --update && \
    apk add --update bash tzdata python py-pip && \
    pip install shadowsocks && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    rm -rf /var/cache/apk/*

ADD entrypoint.sh /root/entrypoint.sh

CMD ["/bin/bash"]
