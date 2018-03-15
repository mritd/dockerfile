FROM node:8.10.0-alpine

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV TAIGA_EVENTS_DOWNLOAD_URL https://github.com/taigaio/taiga-events/archive/master.zip

RUN apk upgrade --update \
    && apk add bash tzdata unzip wget ca-certificates \
	&& npm install -g coffee-script \
	&& wget ${TAIGA_EVENTS_DOWNLOAD_URL} \
	&& unzip master.zip \
    && mv taiga-events-master /usr/local/taiga-events \
    && (cd /usr/local/taiga-events \
    && npm install) \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

WORKDIR /usr/local/taiga-events

CMD ["coffee","index.coffee"]
