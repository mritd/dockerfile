FROM ruby:2.4.1-alpine

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

RUN apk upgrade \
    && apk add \
        bash \
        tzdata \
        nodejs \
        py-pygments \
        git \
        gcc \
        musl-dev \
        make \
    && git clone -b gh-pages https://github.com/zeroclipboard/zeroclipboard.org.git /root/zeroclipboard.org \
    && cd /root/zeroclipboard.org \
    && gem install --no-document bundle \
    && bundle install \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del gcc musl-dev make \
    && rm -rf /var/cache/apk/*

WORKDIR /root
