FROM alpine:3.4

MAINTAINER mritd <mritd@mritd.me>

WORKDIR /root

ENV TZ 'Asia/Shanghai'

ENV SS_VERSION 2.9.0

ENV KCP_VERSION 20161111

RUN apk upgrade --no-cache && \
    apk add --no-cache bash tzdata python py-setuptools wget libsodium && \
    wget --no-check-certificate https://github.com/shadowsocks/shadowsocks/archive/$SS_VERSION.tar.gz && \
    tar -zxvf $SS_VERSION.tar.gz && \
    rm -f shadowsocks-$SS_VERSION/setup.py && \
    wget --no-check-certificate https://raw.githubusercontent.com/shadowsocks/shadowsocks/master/setup.py -O /root/shadowsocks-$SS_VERSION/setup.py && \
    (cd /root/shadowsocks-$SS_VERSION && python setup.py install) && \
    wget --no-check-certificate https://github.com/xtaci/kcptun/releases/download/v$KCP_VERSION/kcptun-linux-amd64-$KCP_VERSION.tar.gz && \
    tar -zxvf kcptun-linux-amd64-$KCP_VERSION.tar.gz && \
    mv server_linux_amd64 /usr/bin/kcptun && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del wget && \
    rm -f client_linux_amd64 kcptun-linux-amd64-$KCP_VERSION.tar.gz $SS_VERSION.tar.gz && \
    rm -rf shadowsocks-$SS_VERSION && \
    rm -rf /var/cache/apk/*

ADD entrypoint.sh /root/entrypoint.sh

ADD kcptun.cfg /etc/kcptun.cfg

ENTRYPOINT ["/root/entrypoint.sh"]
