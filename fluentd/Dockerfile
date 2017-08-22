FROM ruby:2.3.1-alpine

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TZ 'Asia/Shanghai'

ENV FLUENTD_VERSION 0.14.8

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata \
    && apk add --no-cache --virtual .build-deps \
       make gcc g++ bzip2 ruby-dev libc-dev \
    && gem update --system --no-document \
    && gem install --no-document json_pure jemalloc \
    && gem install --no-document fluentd -v ${FLUENTD_VERSION} \
    && gem install --no-document fluent-plugin-kubernetes_metadata_filter -v 0.26.2 \
    && gem install --no-document fluent-plugin-elasticsearch -v 1.8.0 \
    && gem install --no-document fluent-plugin-prometheus -v 0.2.1 \
    && gem cleanup fluentd \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/*

ADD entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
