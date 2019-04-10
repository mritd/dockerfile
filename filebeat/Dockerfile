FROM golang:1.12.2-alpine3.9 as builder

ENV FILEBEAT_VERSION 6.7.1
ENV FILEBEAT_SOURCE_PATH ${GOPATH}/src/github.com/elastic

RUN apk upgrade \
    && apk add git bash python3 build-base \
    && pip3 install virtualenv \
    && mkdir -p ${FILEBEAT_SOURCE_PATH} \
    && cd ${FILEBEAT_SOURCE_PATH} \
    && git clone https://github.com/elastic/beats.git \
    && cd beats/filebeat && git checkout v${FILEBEAT_VERSION} -b v${FILEBEAT_VERSION} \
    && make

FROM alpine:3.9

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV FILEBEAT_VERSION 6.7.1
ENV FILEBEAT_HOME /usr/share/filebeat
ENV FILEBEAT_DOWNLOAD_URL https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz

RUN apk upgrade \
    && apk add bash tzdata wget ca-certificates \
    && adduser filebeat -u 1000 -h ${FILEBEAT_HOME} -s /sbin/nologin -D \
    && wget ${FILEBEAT_DOWNLOAD_URL} -O filebeat.tar.gz \
    && mkdir -p ${FILEBEAT_HOME}/data ${FILEBEAT_HOME}/logs \
    && tar -zxf filebeat.tar.gz -C ${FILEBEAT_HOME} --strip-components 1 \
    && chown -R filebeat:filebeat ${FILEBEAT_HOME} \
    && ln -s ${FILEBEAT_HOME}/filebeat /usr/bin/filebeat \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del wget \
    && rm -rf /filebeat.tar.gz \
        ${FILEBEAT_HOME}/filebeat \
        /var/cache/apk/*

COPY --from=builder /go/src/github.com/elastic/beats/filebeat/filebeat ${FILEBEAT_HOME}/filebeat
COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["-e"]
