FROM mritd/alpine-glibc:3.5

LABEL maintainer="mritd <mritd@linux.com>"

ENV TZ 'Asia/Shanghai'

ENV UPSOURCE_VERSION 3.5.3616

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata wget ca-certificates openjdk8-jre \
    && wget https://download.jetbrains.com/upsource/upsource-${UPSOURCE_VERSION}.zip \
    && unzip upsource-${UPSOURCE_VERSION}.zip \
    && rm -f upsource-${UPSOURCE_VERSION}.zip \
    && mkdir -p /data/{backups,data,logs,tmp} \
    && /upsource-${UPSOURCE_VERSION}/bin/upsource.sh configure \ 
        --backups-dir /data/backups \
        --data-dir    /data/data \
        --logs-dir    /data/logs \
        --temp-dir    /data/tmp \
        --listen-port 8080 \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del wget \
    && rm -rf /var/cache/apk/*

WORKDIR /upsource-${UPSOURCE_VERSION}/bin

EXPOSE 8080

VOLUME /data

CMD ["./upsource.sh","run"]
