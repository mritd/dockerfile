FROM frolvlad/alpine-glibc 

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TZ 'Asia/Shanghai'

ENV MONGO_VERSION 3.4.2

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata curl \
    && apk -X http://dl-cdn.alpinelinux.org/alpine/edge/testing --no-cache add gosu \
    && addgroup -S mongodb \
    && adduser -S -G mongodb mongodb \
    && gosu nobody true \
    && mkdir -p /data/db /data/configdb \
    && chown -R mongodb:mongodb /data/db /data/configdb \
    && curl -SslO https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-${MONGO_VERSION}.tgz \
    && tar -zxvf mongodb-linux-x86_64-${MONGO_VERSION}.tgz \
    && mv mongodb-linux-x86_64-${MONGO_VERSION}/bin/* /usr/local/bin \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del curl \
    && rm -rf mongodb-linux-x86_64-${MONGO_VERSION}.tgz \
            mongodb-linux-x86_64-${MONGO_VERSION} \
            /var/cache/apk/*

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME /data/db /data/configdb

EXPOSE 27017

ENTRYPOINT ["/entrypoint.sh"]

CMD ["mongod"]
