FROM alpine:3.9

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ='Asia/Shanghai'

ENV TZ $TZ
ENV SS_LIBEV_VERSION 3.2.4
ENV KCP_VERSION 20190109
ENV SS_DOWNLOAD_URL https://github.com/shadowsocks/shadowsocks-libev/releases/download/v${SS_LIBEV_VERSION}/shadowsocks-libev-${SS_LIBEV_VERSION}.tar.gz
ENV OBFS_DOWNLOAD_URL https://github.com/shadowsocks/simple-obfs.git
ENV V2RAY_PLUGIN_DOWNLOAD_URL https://github.com/shadowsocks/v2ray-plugin/releases/download/v1.0/v2ray-plugin-linux-amd64-8cea1a3.tar.gz
ENV KCP_DOWNLOAD_URL https://github.com/xtaci/kcptun/releases/download/v${KCP_VERSION}/kcptun-linux-amd64-${KCP_VERSION}.tar.gz

RUN apk upgrade \
    && apk add bash tzdata libsodium rng-tools \
    && apk add --virtual .build-deps \
        autoconf \
        automake \
        xmlto \
        build-base \
        curl \
        c-ares-dev \
        libev-dev \
        libtool \
        linux-headers \
        udns-dev \
        libsodium-dev \
        mbedtls-dev \
        pcre-dev \
        udns-dev \
        tar \
        git \
    && curl -sSLO ${SS_DOWNLOAD_URL} \
    && tar -zxf shadowsocks-libev-${SS_LIBEV_VERSION}.tar.gz \
    && (cd shadowsocks-libev-${SS_LIBEV_VERSION} \
    && ./configure \
        --prefix=/usr \
        --disable-documentation \
    && make install) \
    && git clone ${OBFS_DOWNLOAD_URL} \
    && (cd simple-obfs \
    && git submodule update --init --recursive \
    && ./autogen.sh && ./configure \
        --disable-documentation \
    && make install) \
    && curl -o v2ray_plugin.tar.gz -sSL ${V2RAY_PLUGIN_DOWNLOAD_URL} \
    && tar -zxf v2ray_plugin.tar.gz \
    && mv v2ray-plugin_linux_amd64 /usr/bin/v2ray-plugin \
    && curl -sSLO ${KCP_DOWNLOAD_URL} \
    && tar -zxf kcptun-linux-amd64-${KCP_VERSION}.tar.gz \
    && mv server_linux_amd64 /usr/bin/kcpserver \
    && mv client_linux_amd64 /usr/bin/kcpclient \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && runDeps="$( \
        scanelf --needed --nobanner /usr/bin/ss-* /usr/local/bin/obfs-* \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | xargs -r apk info --installed \
            | sort -u \
        )" \
    && apk add --virtual .run-deps $runDeps \
    && apk del .build-deps \
    && rm -rf kcptun-linux-amd64-${KCP_VERSION}.tar.gz \
        shadowsocks-libev-${SS_LIBEV_VERSION}.tar.gz \
        shadowsocks-libev-${SS_LIBEV_VERSION} \
        simple-obfs \
        v2ray_plugin.tar.gz \
        /var/cache/apk/*

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
