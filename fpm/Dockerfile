FROM ruby:2.6.5-alpine3.11

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

RUN apk upgrade --update \
    && apk add bash tzdata make gcc libc-dev tar git \
    && git clone https://github.com/jordansissel/fpm.git \
    && (cd fpm && make install) \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf fpm /var/cache/apk/*

CMD ["/bin/bash"]
