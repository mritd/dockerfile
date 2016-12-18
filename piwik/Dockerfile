FROM php:7.1.0-fpm-alpine 

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

ENV PIWIK_VERSION 2.17.1

WORKDIR /var/www/html

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && echo "@commuedge https://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && BUILD_DEPS=" \
        git \
        curl \
        gnupg \
        build-base \
        autoconf \
        geoip-dev" \
    && apk add --update \
	tar \
        geoip \
        ${BUILD_DEPS} \
        php7-pdo_mysql@commuedge \
        php7-gd@commuedge \
        php7-opcache@commuedge \
        php7-zlib@commuedge \
        php7-zip@commuedge \
        php7-ldap@commuedge \
        php7-mbstring@commuedge \
        php7-apcu@commuedge \
        php7-mysqli@commuedge \
        php7-dev@commuedge \
        php7-pear@commuedge \
    && pecl install geoip-1.1.1 \
    && docker-php-ext-install -j2 mysqlnd \
    && curl -fsSL -o piwik.tar.gz "https://builds.piwik.org/piwik-${PIWIK_VERSION}.tar.gz" \
    && curl -fsSL -o piwik.tar.gz.asc "https://builds.piwik.org/piwik-${PIWIK_VERSION}.tar.gz.asc" \
    && GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 814E346FA01A20DBB04B6807B5DBD5925590A237 \
    && gpg --batch --verify piwik.tar.gz.asc piwik.tar.gz \
    && rm -r "$GNUPGHOME" piwik.tar.gz.asc \
    && tar -xzf piwik.tar.gz -C /usr/src/ \
    && rm piwik.tar.gz \
    && curl -fsSL -o /usr/src/piwik/misc/GeoIPCity.dat.gz http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz \
    && gunzip /usr/src/piwik/misc/GeoIPCity.dat.gz \
    && apk del ${BUILD_DEPS} php7-dev php7-pear \
    && rm -rf /var/cache/apk/*

COPY php.ini /usr/local/etc/php/php.ini

COPY docker-entrypoint.sh /entrypoint.sh

COPY cron/15min/* /etc/periodic/15min

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm"]
