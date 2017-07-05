FROM mritd/alpine-glibc:3.6 

ENV TZ 'Asia/Shanghai'
ENV FILEBEAT_VERSION 5.4.3
ENV FILEBEAT_DOWNLOAD_URL https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz 

RUN apk upgrade --update \
    && apk add bash tzdata \
    && apk add --virtual=build-dependencies wget ca-certificates \
    && wget ${FILEBEAT_DOWNLOAD_URL} \
    && tar -zxvf filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz /usr/local/filebeat-${FILEBEAT_VERSION}-linux-x86_64 \
    && rm -f filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/*

CMD ["bash"]
