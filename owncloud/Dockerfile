FROM mritd/php7:7.1.9 

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TZ 'Asia/Shanghai'
ENV OWNCLOUD_VERSION 10.0.2
ENV OWNCLOUD_GPGKEY E3036906AD9F30807351FAC32D5D5E97F6978A26
ENV OWNCLOUD_DOWNLOAD_URL https://download.owncloud.org/community/owncloud-${OWNCLOUD_VERSION}.tar.bz2
ENV OWNCLOUD_DOWNLOAD_ASC_URL https://download.owncloud.org/community/owncloud-${OWNCLOUD_VERSION}.tar.bz2.asc

RUN apk upgrade --update \
    && apk add bash tzdata curl ca-certificates \
    && apk add php7-exif php7-gd php7-intl php7-ldap \
        php7-mbstring php7-mcrypt php7-opcache php7-pdo \
        php7-pdo_mysql php7-pdo_pgsql php7-pgsql php7-zip \
        php7-apcu php7-memcached php7-redis \
    && curl -fsSL -o owncloud.tar.bz2 ${OWNCLOUD_DOWNLOAD_URL} \
    && curl -fsSL -o owncloud.tar.bz2.asc ${OWNCLOUD_DOWNLOAD_ASC_URL} \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys ${OWNCLOUD_GPGKEY} \
    && gpg --batch --verify owncloud.tar.bz2.asc owncloud.tar.bz2 \
    && tar -xjf owncloud.tar.bz2 -C /usr/src/ \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf ${GNUPGHOME} \
        owncloud.tar.bz2 \
        owncloud.tar.bz2.asc \
        /var/cache/apk/*

VOLUME /var/www/html

COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["php-fpm"]
