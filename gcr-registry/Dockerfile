# Build a minimal distribution container

FROM alpine:3.5

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata openjdk8-jre libpcap-dev iptables \
                          ca-certificates apache2-utils privoxy \
    && mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/* 

COPY ./registry/registry /bin/registry
COPY ./registry/config-example.yml /etc/docker/registry/config.yml
COPY fuckgfw /fuckgfw/fuckgfw
COPY data /fuckgfw/data

WORKDIR /fuckgfw

VOLUME ["/var/lib/registry"]

EXPOSE 5000

ENTRYPOINT ["/fuckgfw/fuckgfw"]

