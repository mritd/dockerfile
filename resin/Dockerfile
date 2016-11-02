FROM alpine:3.4

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

ENV RESIN_VERSION 4.0.49

RUN apk upgrade --update && \
    apk add --no-cache bash tzdata wget gcc libc-dev make openssl-dev \
            pcre-dev zlib-dev linux-headers curl gnupg libxslt-dev \
            gd-dev geoip-dev  perl-dev && \
    wget http://www.caucho.com/download/resin-$RESIN_VERSION.tar.gz && \
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.tar.gz && \
    tar -zxvf resin-$RESIN_VERSION.tar.gz && \
    tar -zxvf jdk-8u111-linux-x64.tar.gz && \
    mv jdk1.8.0_111 /usr/local && \
    cd resin-$RESIN_VERSION && \
    ./configure --prefix=/usr/local/resin-$RESIN_VERSION \
                --with-java-home=/user/local/jdk1.8.0_111 \
                --enable-64bit && \
    make && make install && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    rm -rf /var/cache/apk/*

CMD ["/bin/bash"]
