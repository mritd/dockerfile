FROM python:3.7.0b1-alpine3.7

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}

RUN apk upgrade --update \
    && apk add bash tzdata \
    && mkdir -p /data/radicale /etc/radicale \
    && pip install --upgrade radicale passlib \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY config /etc/radicale/config
COPY users /data/radicale/users 

CMD ["radicale"]
