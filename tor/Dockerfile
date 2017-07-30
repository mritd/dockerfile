FROM alpine:3.6

LABEL maintainer="mritd <mritd@mritd.me>"

ENV TZ 'Asia/Shanghai'

ENV GOSU_VERSION 1.10

RUN apk upgrade --no-cache \
    && echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    && apk add --no-cache tor@testing curl bash tzdata \
    && curl -L -H "Cache-Control: no-cache" -o /usr/local/bin/gosu \
        https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 \
    && chmod +x /usr/local/bin/gosu \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del curl \
    && rm -rf /var/cache/apk/*

COPY torrc /etc/tor/torrc

CMD ["/bin/bash"]
