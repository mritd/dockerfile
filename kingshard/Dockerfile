FROM alpine:3.4

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --no-cache && \
    apk add --no-cache bash tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    rm -rf /var/cache/apk/*

ADD kingshard /root/kingshard

ADD ks.yaml /etc/ks.yaml

CMD ["/root/kingshard"]
