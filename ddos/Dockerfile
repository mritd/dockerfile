FROM python:2.7.12-alpine

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --no-cache && \
    apk add --no-cache bash tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    rm -rf /var/cache/apk/*

ADD ChiHULK.py /ChiHULK.py

ADD entrypoint.sh /entrypoint.sh

ADD fuck /etc/periodic/15min

CMD ["/entrypoint.sh"]
