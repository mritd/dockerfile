FROM alpine:3.5

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TZ 'Asia/Shanghai'

ENV FRP_VERSION 0.9.3

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata curl \
    && mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 \
    && curl -sSLO https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && tar -zxvf frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && mv frp_${FRP_VERSION}_linux_amd64/frps /usr/bin \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf frp_${FRP_VERSION}_linux_amd64.tar.gz frp_${FRP_VERSION}_linux_amd64 /var/cache/apk/*

ADD frps.ini /etc/frps.ini

CMD ["frps","-c","/etc/frps.ini"]
