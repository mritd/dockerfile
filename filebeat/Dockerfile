FROM mritd/alpine-glibc:3.6 

ENV TZ 'Asia/Shanghai'
ENV FILEBEAT_VERSION 5.4.3
ENV FILEBEAT_DOWNLOAD_URL https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz 

RUN apk upgrade --update \
    && apk add bash tzdata \
    && apk add --virtual=build-dependencies wget ca-certificates \
    && wget ${FILEBEAT_DOWNLOAD_URL} \
    && tar -zxvf filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz -C /usr/local \
    && rm -f filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz \
        /usr/lcoal/filebeat-${FILEBEAT_VERSION}-linux-x86_64/*.yml \
        /usr/lcoal/filebeat-${FILEBEAT_VERSION}-linux-x86_64/*.json \
        /usr/lcoal/filebeat-${FILEBEAT_VERSION}-linux-x86_64/.build_hash.txt \
        /usr/lcoal/filebeat-${FILEBEAT_VERSION}-linux-x86_64/NOTICE \
        /usr/lcoal/filebeat-${FILEBEAT_VERSION}-linux-x86_64/README.md \
    && ln -s /usr/lcoal/filebeat-${FILEBEAT_VERSION}-linux-x86_64/filebeat /usr/local/bin/filebeat \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && mkdir /etc/filebeat \
    && apk del build-dependencies \
    && rm -rf /var/cache/apk/*

VOLUME /etc/filebeat/filebeat.yml

CMD ["filebeat","-e","-c","/etc/filebeat/filebeat.yml"]
