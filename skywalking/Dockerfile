FROM openjdk:8u131-jdk-alpine 

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV JAVA_OPTS "-Xms256M -Xmx512M"
ENV JAVA_CLASSPATH "/skywalking-collector/libs/*:/skywalking-collector/config"
ENV COLLECTOR_OPTIONS ""
ENV JAVA_CLASSPATH "/skywalking-collector/libs/*:/skywalking-collector/config"
ENV SKYWALKING_VERSION 3.2.2
ENV SKYWALKING_HOME /skywalking-collector
ENV SKYWALKING_CONFIG_DIR 
ENV SKYWALKING_DOWNLOAD_URL https://github.com/wu-sheng/sky-walking/releases/download/v${SKYWALKING_VERSION}/skywalking-collector.tar.gz

RUN apk upgrade --update \
    && apk add bash tzdata curl \
    && curl -sfSL ${SKYWALKING_DOWNLOAD_URL} -o skywalking-collector.tar.gz \
    && tar -zxf skywalking-collector.tar.gz \
    && chmod -R 644 skywalking-collector \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /skywalking-collector/bin \
            /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh

EXPOSE 10800 11800 12800

CMD ["/entrypoint.sh"]
