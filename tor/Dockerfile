FROM alpine:3.10

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}

RUN apk upgrade --update \
    && apk add tor privoxy bash tzdata su-exec \
    && ln -sf /dev/stdout /var/log/tor/notices.log \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY torrc /etc/tor/torrc

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
