FROM ruby:2.3.1-alpine

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --no-cache && \
    apk add --no-cache bash tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del gcc musl-dev make && \
    rm -rf /var/cache/apk/*

CMD ["/bin/bash"]
