FROM alpine:3.8

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV FILEBEAT_VERSION 6.5.2
ENV FILEBEAT_HOME /usr/share/filebeat
ENV FILEBEAT_DOWNLOAD_URL https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz 

RUN apk upgrade \
    && apk add bash tzdata libc6-compat \
    && apk add --virtual=build-dependencies wget ca-certificates \
    && wget -q ${FILEBEAT_DOWNLOAD_URL} \
    && mkdir -p ${FILEBEAT_HOME}/data ${FILEBEAT_HOME}/logs \
    && tar -zxf filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz \
        -C ${FILEBEAT_HOME} --strip-components 1 \
    && rm -f filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz \
        ${FILEBEAT_HOME}/.build_hash.txt \
        ${FILEBEAT_HOME}/NOTICE \
        ${FILEBEAT_HOME}/README.md \
    && ln -s ${FILEBEAT_HOME}/filebeat /usr/bin/filebeat \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && mkdir /etc/filebeat \
    && apk del build-dependencies \
    && rm -rf /var/cache/apk/*

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME /etc/filebeat

ENTRYPOINT ["/entrypoint.sh"]

CMD ["-e","-c","/etc/filebeat.yaml"]
