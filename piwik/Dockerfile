FROM alpine:3.4

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

ENV PIWIK_VERSION 2.17.1

WORKDIR /var/www/html

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk add --no-cache \
        tar \
        git \
        curl \
        gnupg \
        geoip \
        php7-fpm@commuedge \
        php7-curl@commuedge \
        php7-session@commuedge \
        php7-json@commuedge \
        php7-ctype@commuedge \
        php7-pdo_mysql@commuedge \
        php7-gd@commuedge \
        php7-opcache@commuedge \
        php7-zlib@commuedge \
        php7-zip@commuedge \
        php7-ldap@commuedge \
        php7-mbstring@commuedge \
        php7-apcu@commuedge \
        php7-iconv@commuedge \
        php7-dom@commuedge \
        php7-openssl@commuedge \
        php7-mysqli@commuedge \
        php7-dev@commuedge \
        php7-pear@commuedge \
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
    && git clone https://github.com/Zakay/geoip \
    && cd geoip && phpize7 && ./configure \
        && --with-php-config=/usr/bin/php-config7 \
    && make && make install \
    && addgroup -g 82 -S www-data \
    && adduser -u 82 -D -S -G www-data www-data \
    && rm -rf /var/cache/apk/*

COPY php.ini /etc/php7/conf.d/php.ini

COPY docker.conf /etc/php7/php-fpm.d/docker.conf

COPY docker-entrypoint.sh /entrypoint.sh

COPY cron/15min/* /etc/periodic/15min

VOLUME /var/www/html

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm7"]
