FROM golang:1.10.3-alpine3.7 AS builder

COPY env2yaml.go /go/env2yaml.go

RUN apk add git --update \
    && go get gopkg.in/yaml.v2 \
    && go build env2yaml.go

FROM openjdk:8u171-jre-alpine3.7

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV LOGSTASH_VERSION 6.3.0
ENV LOGSTASH_HOME /usr/local/logstash
ENV LOGSTASH_TARBALL https://artifacts.elastic.co/downloads/logstash/logstash-${LOGSTASH_VERSION}.tar.gz 

# ensure logstash user exists
RUN set -ex \
    && addgroup -S logstash \
    && adduser -S -G logstash logstash \
    && apk upgrade --update \
    && apk add 'su-exec>=0.2' bash tzdata \
    && apk add --virtual .fetch-deps \
        wget \
        ca-certificates \
        tar \
    && wget -O logstash.tar.gz "${LOGSTASH_TARBALL}" \
    && tar -zxf logstash.tar.gz \
    && mv logstash-${LOGSTASH_VERSION} ${LOGSTASH_HOME} \
    && mkdir -p /data/logstash /var/log/logstash \
    && chown -R logstash:logstash ${LOGSTASH_HOME} /data /var/log/logstash \
    && ln -sf ${LOGSTASH_HOME}/bin/* /usr/local/bin \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del .fetch-deps \
    && rm -rf logstash.tar.gz.asc \
        logstash.tar.gz \
        ${logstash_HOME}/config \
        ${logstash_HOME}/bin/*.exe \
        ${logstash_HOME}/bin/*.bat \
        /var/cache/apk/*

COPY --from=builder /go/env2yaml /usr/bin/env2yaml
COPY config ${LOGSTASH_HOME}/config
COPY pipeline ${LOGSTASH_HOME}/pipeline
COPY docker-entrypoint.sh /entrypoint.sh

VOLUME /data /var/log/logstash 

ENTRYPOINT ["/entrypoint.sh"]
