FROM alpine:edge 

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

ENV PIWIK_VERSION 2.17.1

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk add --no-cache \
        tar \
        curl \
        gnupg \
        geoip \
        php7 \
        php7-fpm \
        php7-pdo_mysql \
        php7-gd \
        php7-opcache \
        php7-zlib \
        php7-zip \
        php7-ldap \
        php7-mbstring \
        php7-apcu \
    && mkdir /usr/src \
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
    && addgroup -g 82 -S www-data \
    && adduser -u 82 -G www-data -h /home/www-data -s /bin/false -S www-data \
    && rm -rf /var/cache/apk/*

COPY php.ini /usr/local/etc/php/php.ini

COPY docker-entrypoint.sh /entrypoint.sh

COPY cron/15min/* /etc/periodic/15min

VOLUME /var/www/html

WORKDIR /var/www/html

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm"]
