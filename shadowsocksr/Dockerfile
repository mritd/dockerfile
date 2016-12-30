FROM alpine:3.5

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'
ENV SSR_VERSION 2.5.6

RUN apk upgrade --no-cache && \
    apk add --no-cache bash tzdata && \
    apk add --no-cache --virtual .build-deps \
      asciidoc autoconf build-base curl libtool \
      linux-headers openssl-dev pcre-dev xmlto && \
    curl -fSL https://github.com/shadowsocks/shadowsocks-libev/archive/v$SSR_VERSION.tar.gz -o v$SSR_VERSION.tar.gz && \
    tar -zxvf v$SSR_VERSION.tar.gz && \
    (cd shadowsocks-libev-$SSR_VERSION && \
    ./configure --prefix=/usr/local --disable-documentation && \
    make install) && \
    runDeps="$( scanelf --needed --nobanner /usr/local/bin/ss-* \
              | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
              | xargs -r apk info --installed \
              | sort -u \
            )" && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk add --no-cache --virtual .run-deps $runDeps && \
    apk del .build-deps && \
    rm -r v$SSR_VERSION.tar.gz && \
    rm -rf shadowsocks-libev-$SSR_VERSION && \
    rm -rf /var/cache/apk/*

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
