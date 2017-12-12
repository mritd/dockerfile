FROM openjdk:8u151-alpine

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV JAVA_OPTS "-Xms256M -Xmx512M"
ENV SKYWALKING_VERSION 3.2.6
ENV SKYWALKING_COLLECTOR_OPTS ""
ENV SKYWALKING_HOME /usr/local/skywalking-ui
ENV SKYWALKING_CONFIG_DIR ${SKYWALKING_HOME}/config
ENV SKYWALKING_CLASSPATH "${SKYWALKING_HOME}/libs/*:${SKYWALKING_CONFIG_DIR}"
ENV SKYWALKING_DOWNLOAD_URL https://github.com/wu-sheng/sky-walking-ui/releases/download/v${SKYWALKING_VERSION}/skywalking-web.tar.gz 

RUN apk upgrade --update \
    && apk add bash tzdata curl \
    && curl -sfSL ${SKYWALKING_DOWNLOAD_URL} -o skywalking-web.tar.gz \
    && tar -zxf skywalking-web.tar.gz \
    && mv skywalking-web ${SKYWALKING_HOME} \
    && chmod -R 644 ${SKYWALKING_HOME} \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del curl \
    && rm -rf skywalking-web.tar.gz \
            ${SKYWALKING_HOME}/bin \
            /var/cache/apk/*

COPY log4j2.xml ${SKYWALKING_CONFIG_DIR}
COPY entrypoint.sh /entrypoint.sh

EXPOSE 8080 

CMD ["/entrypoint.sh"]
