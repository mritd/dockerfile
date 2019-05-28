FROM nginx:1.15.12-alpine

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}

RUN apk upgrade --update \
    && apk add bash git \
    && rm -rf /usr/share/nginx/html \
    && git clone https://github.com/mritd/mritd.me.git /usr/share/nginx/html \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh
COPY flush /usr/local/bin/flush

WORKDIR /usr/share/nginx/html

CMD ["/entrypoint.sh"]
