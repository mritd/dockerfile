FROM golang:1.11.0-stretch AS builder

COPY env2yaml.go /go/env2yaml.go

RUN go get gopkg.in/yaml.v2 \
    && go build env2yaml.go

FROM openjdk:8u181-jdk-slim-stretch

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV LANG 'en_US.UTF-8'
ENV LC_ALL 'en_US.UTF-8'
ENV LOGSTASH_VERSION 6.4.0
ENV LOGSTASH_HOME /usr/share/logstash
ENV LOGSTASH_TARBALL https://artifacts.elastic.co/downloads/logstash/logstash-${LOGSTASH_VERSION}.tar.gz 

RUN set -ex \
    && apt update \
    && apt upgrade -y \
    && apt install tzdata wget ca-certificates tar \
    && groupadd --gid 1000 logstash \
    && useradd --uid 1000 --gid 1000 --home ${LOGSTASH_HOME} logstash \
    && wget -O logstash.tar.gz "${LOGSTASH_TARBALL}" \
    && tar -zxf logstash.tar.gz \
    && mv logstash-${LOGSTASH_VERSION} -C ${LOGSTASH_HOME} \
    && mkdir -p /data /var/log/logstash \
    && chown -R logstash:logstash ${LOGSTASH_HOME} /data /var/log/logstash \
    && ln -sf ${LOGSTASH_HOME}/bin/* /usr/bin \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apt autoclean \
    && rm -rf logstash.tar.gz.asc \
        logstash.tar.gz \
        ${logstash_HOME}/config \
        ${logstash_HOME}/bin/*.exe \
        ${logstash_HOME}/bin/*.bat

COPY --from=builder /go/env2yaml /usr/bin/env2yaml
COPY config ${LOGSTASH_HOME}/config
COPY pipeline ${LOGSTASH_HOME}/pipeline
COPY docker-entrypoint.sh /entrypoint.sh

EXPOSE 9600 5044

VOLUME /data /var/log/logstash 

ENTRYPOINT ["/entrypoint.sh"]
