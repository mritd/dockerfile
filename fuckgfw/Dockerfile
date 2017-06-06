FROM alpine:3.6

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata openjdk8 libpcap-dev iptables \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/* \
    && wget http://mritdftp.b0.upaiyun.com/files/fuckgfw.tar.gz \
    && tar -zxvf fuckgfw.tar.gz \
    && rm -f fuckgfw.tar.gz

WORKDIR /fuckgfw

CMD ["java","-jar","fuckgfw.jar","-b"]
