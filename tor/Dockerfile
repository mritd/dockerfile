FROM alpine:3.6

LABEL maintainer="mritd <mritd@mritd.me>"

ENV TZ 'Asia/Shanghai'

ENV GOSU_VERSION 1.10

RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    && apk upgrade --update \
    && apk add tor@testing curl bash tzdata \
    && curl -L -H "Cache-Control: no-cache" -o /usr/local/bin/gosu \
        https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 \
    && ln -sf /dev/stdout /var/log/tor/notices.log \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && chmod +x /usr/local/bin/gosu \
    && chown tor:tor /var/log/tor/notices.log \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del curl \
    && rm -rf /var/cache/apk/*

COPY torrc /etc/tor/torrc

CMD ["gosu","tor","tor"]
