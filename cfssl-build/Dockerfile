FROM golang:1.14.2-stretch

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

RUN set -ex \
    && apt update \
    && apt upgrade -y \
    && apt install tzdata ruby ruby-dev rubygems fakeroot build-essential -y \
    && gem install --no-document fpm \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/lib/apt/lists/*

COPY build.sh /go/build.sh

VOLUME /dist

CMD ["/bin/bash"]
