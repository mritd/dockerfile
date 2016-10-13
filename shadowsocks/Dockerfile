FROM alpine:3.4

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

WORKDIR /root

ENV SS_VERSION 2.9.0

ENV KCP_VERSION 20161009

RUN apk upgrade --update && \
    apk add --update bash tzdata python py-setuptools wget && \
    wget --no-check-certificate https://github.com/shadowsocks/shadowsocks/archive/$SS_VERSION.tar.gz && \
    tar -zxvf $SS_VERSION.tar.gz && rm -f shadowsocks-$SS_VERSION/setup.py && \
    wget --no-check-certificate https://raw.githubusercontent.com/shadowsocks/shadowsocks/master/setup.py -O /root/shadowsocks-$SS_VERSION/setup.py && \
    (cd /root/shadowsocks-$SS_VERSION && python setup.py install) && \
    wget --no-check-certificate https://github.com/xtaci/kcptun/releases/download/v$KCP_VERSION/kcptun-linux-amd64-$KCP_VERSION.tar.gz && \
    tar -zxvf kcptun-linux-amd64-$KCP_VERSION.tar.gz && mv server_linux_amd64 /usr/bin/kcptun && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    rm -f client_linux_amd64 kcptun-linux-amd64-20161009.tar.gz && \
    rm -rf shadowsocks-$SS_VERSION $SS_VERSION.tar.gz && \
    rm -rf /var/cache/apk/*

ADD entrypoint.sh /root/entrypoint.sh

ADD kcptun.cfg /etc/kcptun.cfg

ENTRYPOINT ["/root/entrypoint.sh"]
