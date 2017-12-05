FROM alpine:3.7

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV Version 2.2.1

RUN \
    addgroup -S tengine \
    && adduser -D -S -h /var/lib/tengine -s /sbin/nologin -G tengine tengine \
    && addgroup -S www-data \
    && adduser tengine www-data \
    # install make Dependence
    && apk add --update \
        gcc \
        libc-dev \
        make \
        openssl-dev \
        pcre-dev \
        zlib-dev \
        linux-headers \
        jemalloc-dev \
        geoip-dev \
        tzdata \
        wget \
        tar \
        gzip \
    # compile & install 
    && mkdir /install \
    && (cd /install \ 
    && wget http://tengine.taobao.org/download/tengine-$Version.tar.gz  \
    && tar -zxC .  -f /install/tengine-$Version.tar.gz ) \
    && (cd /install/tengine-$Version \
    && ./configure \
      --prefix=/etc/tengine \
      --conf-path=/etc/tengine/tengine.conf \
      --sbin-path=/usr/sbin/tengine \
      --dso-path=/etc/tengine/modules \
      --dso-tool-path=/usr/sbin/dso_tool \
      --pid-path=/var/run/tengine.pid \
      --lock-path=/var/run/lock/tengine.lock \
      --user=tengine \
      --group=www-data \
      --http-log-path=/var/log/tengine/access.log \
      --error-log-path=/var/log/tengine/error.log \
      --http-client-body-temp-path=/var/lib/tengine/client-body \
      --http-proxy-temp-path=/var/lib/tengine/proxy \
      --http-fastcgi-temp-path=/var/lib/tengine/fastcgi \
      --http-scgi-temp-path=/var/lib/tengine/scgi \
      --http-uwsgi-temp-path=/var/lib/tengine/uwsgi \
      --with-imap \
      --with-imap_ssl_module \
      --with-ipv6 \
      --with-pcre-jit \
      --with-http_dav_module \
      --with-http_geoip_module=shared \
      --with-http_gunzip_module \
      --with-http_gzip_static_module \
      --with-http_random_index_module \
      --with-http_memcached_module=shared \
      --with-http_realip_module \
      --with-http_secure_link_module=shared \
      --with-http_ssl_module \
      --with-http_v2_module \
      --with-http_stub_status_module \
      --with-http_addition_module \
      --with-http_degradation_module \
      --with-http_flv_module=shared \
      --with-http_mp4_module=shared\
      --with-http_sub_module=shared \
      --with-http_sysguard_module=shared \
      --with-http_reqstat_module=shared \
      --with-file-aio \
      --with-mail \
      --with-mail_ssl_module \
      --with-jemalloc --with-debug \
    && make install \
    && chown tengine:www-data /var/log/tengine \
    && chmod 750 /var/log/tengine \
    && install -d /var/lib/tengine /var/www/tengine \
    && chown tengine:www-data /var/www/tengine) \
    # forward request and error logs to docker log collector
    && ln -sf /dev/stdout /var/log/tengine/access.log \
    && ln -sf /dev/stderr /var/log/tengine/error.log \
    # Remove unneeded packages/files
    && apk del gcc linux-headers make wget tar gzip \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf ~/* ~/.git ~/.gitignore ~/.travis.yml ~/.ash_history \
    && rm -rf /install \
    && rm -rf /var/cache/apk/*
    
EXPOSE 80 443

WORKDIR /var/www

CMD ["tengine", "-g", "daemon off;"]
