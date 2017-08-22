FROM alpine:3.6

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TZ 'Asia/Shanghai'

ENV GOSU_VERSION 1.10

RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    && apk upgrade --update \
    && apk add tor@testing runit@testing curl privoxy bash tzdata \
    && curl -L -H "Cache-Control: no-cache" -o /usr/local/bin/gosu \
        https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 \
    && ln -sf /dev/stdout /var/log/tor/notices.log \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && chmod +x /usr/local/bin/gosu \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del curl \
    && rm -rf /var/cache/apk/*

COPY torrc /etc/tor/torrc

COPY service /etc/service

CMD ["runsvdir","/etc/service"]
