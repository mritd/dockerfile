FROM php:7.2.0-fpm-alpine3.6

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV EOLINKER_VERSION 3.1.9
ENV EOLINKER_DOWNLOAD_URL https://raw.githubusercontent.com/eolinker/eoLinker-API-Management-System-OS-3.X/master/release%5B%E6%AD%A3%E5%BC%8F%E5%AE%89%E8%A3%85%E5%8C%85%5D/eolinker_os_${EOLINKER_VERSION}.zip

RUN apk upgrade --update \
    && apk add bash tzdata zip wget \
    && wget ${EOLINKER_DOWNLOAD_URL} -O /usr/src/eolinker_os_${EOLINKER_VERSION}.zip \
    && unzip /usr/src/eolinker_os_${EOLINKER_VERSION}.zip -d /var/www/html \
    && chown -R www-data /var/www/html \
    && docker-php-ext-install pdo_mysql \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del wget zip \
    && rm -rf /var/cache/apk/*

VOLUME /var/www/html

CMD ["php-fpm"]
