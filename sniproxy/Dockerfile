FROM alpine:3.4

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --no-cache && \
    apk add --no-cache bash tzdata sniproxy && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    rm -rf /var/cache/apk/*

COPY sniproxy.conf /etc/sniproxy.conf

COPY entrypoint.sh /entrypoint.sh

EXPOSE 53

ENTRYPOINT ["/entrypoint.sh"]
