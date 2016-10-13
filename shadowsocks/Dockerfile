FROM alpine:3.4

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

WORKDIR /root

RUN apk upgrade --update && \
    apk add --update bash tzdata python py-setuptools wget && \
    wget --no-check-certificate https://github.com/shadowsocks/shadowsocks/archive/2.9.0.tar.gz && \
    tar -zxvf 2.9.0.tar.gz && rm -f shadowsocks-2.9.0/setup.py && \
    wget --no-check-certificate https://raw.githubusercontent.com/shadowsocks/shadowsocks/master/setup.py -O /root/shadowsocks-2.9.0/setup.py && \
    (cd /root/shadowsocks-2.9.0 && python setup.py install) &&  rm -rf shadowsocks-2.9.0 2.9.0.tar.gz && \
    wget --no-check-certificate https://github.com/xtaci/kcptun/releases/download/v20161009/kcptun-linux-amd64-20161009.tar.gz && \
    tar -zxvf kcptun-linux-amd64-20161009.tar.gz && mv server_linux_amd64 /usr/bin/kcptun && rm -f client_linux_amd64 && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    rm -rf /var/cache/apk/*

ADD entrypoint.sh /root/entrypoint.sh
ADD kcptun.cfg /etc/kcptun.cfg

ENTRYPOINT ["/root/entrypoint.sh"]
