FROM alpine:3.6

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/*

CMD ["/bin/bash"]
