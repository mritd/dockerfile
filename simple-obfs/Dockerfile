FROM alpine:3.8

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}
ENV OBFS_DOWNLOAD_URL https://github.com/shadowsocks/simple-obfs.git

RUN apk upgrade --update \
    && apk add bash tzdata \
    && apk add --virtual .build-deps \
        asciidoc \
        autoconf \
        automake \
        g++ \
        gcc \
        libev-dev \
        libpcre32 \
        libtool \
        linux-headers \
        make \
        openssl \
        xmlto \
        zlib-dev \
        git \
    && git clone ${OBFS_DOWNLOAD_URL} \
    && (cd simple-obfs \
    && git submodule update --init --recursive \
    && ./autogen.sh && ./configure --disable-documentation\
    && make && make install) \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo $TZ > /etc/timezone \
    && runDeps="$( \
        scanelf --needed --nobanner /usr/local/bin/obfs-* \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | xargs -r apk info --installed \
            | sort -u \
        )" \
    && apk add --virtual .run-deps $runDeps \
    && apk del .build-deps \
    && rm -rf simple-obfs \
        /var/cache/apk/*

CMD ["obfs-server","--help"]
