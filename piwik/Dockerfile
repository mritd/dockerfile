FROM php:7.2.0-fpm-alpine3.6

LABEL maintainer="mritd <mritd@linux.com>"

ENV TZ 'Asia/Shanghai'

ENV PIWIK_VERSION 3.3.0

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && BUILD_DEPS=" \
        git \
        curl \
        gnupg \
        build-base \
        autoconf \
        zip " \
    && apk add --update \
	tar \
        geoip \
        geoip-dev \
        libjpeg-turbo-dev \
        freetype-dev \
        libpng-dev \
        openldap-dev \
        ${BUILD_DEPS} \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure ldap \
        --with-libdir=lib/ \
    && NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && docker-php-ext-install -j${NPROC} \
        gd \
        mbstring \
        pdo_mysql \
        zip \
        ldap \
        opcache \
    && pecl install APCu  geoip-1.1.1 \
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
    && apk del ${BUILD_DEPS} \
    && rm -rf /var/cache/apk/*

COPY php.ini /usr/local/etc/php/php.ini

COPY docker-entrypoint.sh /entrypoint.sh

COPY cron/15min/* /etc/periodic/15min

VOLUME /var/www/html

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm"]
