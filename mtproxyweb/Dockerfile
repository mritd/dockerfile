FROM nginx:1.14.1-alpine

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}

RUN apk upgrade --update \
    && apk add bash git \
    && rm -rf /usr/share/nginx/html \
    && git clone https://github.com/mritd/mtproxyweb.git /usr/share/nginx/html \
    && chown -R nginx:nginx /usr/share/nginx/html \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /usr/share/nginx/html/.git /var/cache/apk/*

ADD entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
