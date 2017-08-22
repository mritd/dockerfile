FROM alpine:3.6

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --update \
    && apk add bash tzdata openjdk8-jre libpcap-dev iptables ca-certificates wget \
    && update-ca-certificates \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/* \
    && wget https://mritdftp.b0.upaiyun.com/files/fuckgfw.tar.gz \
    && tar -zxvf fuckgfw.tar.gz \
    && rm -f fuckgfw.tar.gz

WORKDIR /fuckgfw

CMD ["java","-jar","fuckgfw.jar","-b"]
