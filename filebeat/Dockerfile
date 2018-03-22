FROM alpine:3.7 

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV FILEBEAT_VERSION 6.2.3
ENV FILEBEAT_HOME /usr/local/filebeat
ENV FILEBEAT_DOWNLOAD_URL https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz 

RUN apk upgrade --update \
    && apk add bash tzdata \
    && apk add --virtual=build-dependencies wget ca-certificates \
    && wget ${FILEBEAT_DOWNLOAD_URL} \
    && mkdir ${FILEBEAT_HOME} \
    && tar -zxvf filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz -C ${FILEBEAT_HOME} --strip-components 1 \
    && rm -f filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz \
        ${FILEBEAT_HOME}/.build_hash.txt \
        ${FILEBEAT_HOME}/NOTICE \
        ${FILEBEAT_HOME}/README.md \
    && ln -s ${FILEBEAT_HOME}/filebeat /usr/local/bin/filebeat \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && mkdir /etc/filebeat \
    && apk del build-dependencies \
    && rm -rf /var/cache/apk/*

VOLUME /etc/filebeat

CMD ["filebeat","-e","-c","/etc/filebeat/filebeat.yaml"]
