FROM php:7.2.0-fpm-alpine3.6

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV EOLINKER_VERSION 3.1.9

COPY eolinker_os_${EOLINKER_VERSION}.zip /usr/src/eolinker_os_${EOLINKER_VERSION}.zip

RUN apk upgrade --update \
    && apk add bash tzdata zip wget \
    && unzip /usr/src/eolinker_os_${EOLINKER_VERSION}.zip -d /var/www/html \
    && chown -R www-data /var/www/html \
    && docker-php-ext-install pdo_mysql \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

VOLUME /var/www/html

CMD ["php-fpm"]
