FROM alpine:3.4

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

WORKDIR /root

RUN apk upgrade --update && \
    apk add --update bash tzdata python py-setuptools wget && \
    wget https://github.com/shadowsocks/shadowsocks/archive/2.9.0.tar.gz && \
    tar -zxvf 2.9.0.tar.gz && rm -f /root/shadowsocks-2.9.0/setup.py && \
    wget https://github.com/shadowsocks/shadowsocks/blob/master/setup.py -O /root/shadowsocks-2.9.0/setup.py && \
    (cd /root/shadowsocks-2.9.0 && python setup.py install) &&  rm -rf shadowsocks-2.9.0 && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    rm -rf /var/cache/apk/*

ADD entrypoint.sh /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]
