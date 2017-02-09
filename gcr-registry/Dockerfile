# Build a minimal distribution container

FROM alpine:3.5

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata openjdk8 libpcap-dev iptables \
                          ca-certificates apache2-utils privoxy \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/* \
    && wget http://upyun.mritd.me/files/fuckgfw.tar.gz \
    && tar -zxvf fuckgfw.tar.gz \
    && rm -f fuckgfw.tar.gz

COPY ./registry/registry /bin/registry
COPY ./registry/config-example.yml /etc/docker/registry/config.yml
COPY docker-entrypoint.sh /entrypoint.sh

WORKDIR /fuckgfw

VOLUME ["/var/lib/registry"]

EXPOSE 5000

ENTRYPOINT ["/entrypoint.sh"]

