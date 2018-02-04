FROM alpine:3.7

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}

RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    && apk upgrade --update \
    && apk add tor@testing privoxy bash tzdata su-exec \
    && ln -sf /dev/stdout /var/log/tor/notices.log \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY torrc /etc/tor/torrc

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
