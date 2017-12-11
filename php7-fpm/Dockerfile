FROM alpine:3.7

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TZ 'Asia/Shanghai'
ENV PHP_VERSION 7.1.9
ENV PHP_INI_DIR /usr/local/etc/php
ENV PHP_URL https://secure.php.net/get/php-${PHP_VERSION}.tar.xz/from/this/mirror
ENV PHP_ASC_URL https://secure.php.net/get/php-${PHP_VERSION}.tar.xz.asc/from/this/mirror
ENV PHP_SHA256 ec9ca348dd51f19a84dc5d33acfff1fba1f977300604bdac08ed46ae2c281e8c
ENV GPG_KEYS A917B1ECDA84AEC2B568FED6F50ABC807BD5DCD0 528995BFEDFBA7191D46839EF9BA0ADA31CBD89E

COPY docker-php* /usr/local/bin/

RUN apk upgrade --update \
    && apk add bash tzdata \
    && apk add --virtual .persistent-deps \
        ca-certificates \
        curl \
        tar \
        xz \
    && apk add --virtual .fetch-deps \
        gnupg \
        openssl \
    && apk add --virtual .build-deps \
        autoconf \
        dpkg \
        dpkg-dev \
        file \
        g++ \
        gcc \
        libc-dev \
        make \
        pcre-dev \
        pkgconf \
        re2c \
        coreutils \
        curl-dev \
        libedit-dev \
        libxml2-dev \
        openssl-dev \
        sqlite-dev \
    && export CFLAGS="-fstack-protector-strong -fpic -fpie -O2" \
    && export CPPFLAGS="${CFLAGS}" \
    && export LDFLAGS="-Wl,-O1 -Wl,--hash-style=both -pie" \
    && export GNUPGHOME="$(mktemp -d)" \
    && mkdir -p /usr/src ${PHP_INI_DIR}/conf.d \
    && wget -O /usr/src/php.tar.xz ${PHP_URL} \
    && wget -O /usr/src/php.tar.xz.asc ${PHP_ASC_URL} \
    && echo "${PHP_SHA256} /usr/src/php.tar.xz" | sha256sum -c - \
    && for key in ${GPG_KEYS}; do \
          gpg --keyserver ha.pool.sks-keyservers.net --recv-keys ${key}; \
       done \
    && gpg --batch --verify /usr/src/php.tar.xz.asc /usr/src/php.tar.xz \
    && docker-php-source extract \
    && ( cd /usr/src/php \
    && gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
    && ./configure \
        --build="${gnuArch}" \
        --with-config-file-path=${PHP_INI_DIR} \
        --with-config-file-scan-dir=${PHP_INI_DIR}\conf.d \
        --disable-cgi \
        --enable-ftp \
        --enable-mbstring \
        --enable-mysqlnd \
        --with-curl \
        --with-libedit \
        --with-openssl \
        --with-zlib \
        --with-pcre-regex=/usr \
        --enable-fpm \
        --with-fpm-user=www-data \
        --with-fpm-group=www-data \ 
    && make -j "$(nproc)" \
    && make install \
    && { find /usr/local/bin /usr/local/sbin -type f -perm +0111 -exec strip --strip-all '{}' + || true; } \
    && make clean ) \
    && docker-php-source delete \
    && runDeps="$( \
        scanelf --needed --nobanner --recursive /usr/local \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | sort -u \
            | xargs -r apk info --installed \
            | sort -u \
        )" \
    && apk add --virtual .php-rundeps $runDeps \
    && pecl update-channels \
    && addgroup -g 82 -S www-data \
    && adduser -u 82 -D -S -G www-data www-data \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del .build-deps .fetch-deps \
    && rm -rf /tmp/pear \
            ~/.pearrc \
            /usr/src/* \
            /var/cache/apk/*

COPY php-fpm.conf /usr/local/etc

COPY php-fpm.d /usr/local/etc/php-fpm.d

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["php", "-a"]
