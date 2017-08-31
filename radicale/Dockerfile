FROM python:3.6.2-alpine3.6 

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --update \
    && apk add bash tzdata \
    && mkdir -p /data/radicale /etc/radicale \
    && pip install --upgrade radicale passlib \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY config /etc/radicale/config
COPY users /data/radicale/users 

CMD ["radicale"]
