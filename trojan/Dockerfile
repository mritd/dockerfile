FROM alpine:3.9

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}
ENV VERSION v1.11.0
ENV DOWNLOAD_URL https://github.com/trojan-gfw/trojan/archive/${VERSION}.tar.gz
ENV LINUX_HEADERS_DOWNLOAD_URL=http://dl-cdn.alpinelinux.org/alpine/v3.7/main/x86_64/linux-headers-4.4.6-r2.apk

RUN set -ex \
    && apk upgrade \
    && apk add bash tzdata\
    && apk add --virtual .build-deps \
        build-base \
        boost-dev \
        curl \
        cmake \
        mariadb-dev \
        tar \
        git \
    && curl -sSL ${LINUX_HEADERS_DOWNLOAD_URL} > /linux-headers-4.4.6-r2.apk \
    && apk add --virtual .build-deps-kernel /linux-headers-4.4.6-r2.apk \
    && curl -sSL ${DOWNLOAD_URL} > trojan.tar.gz \ 
    && mkdir -p trojan/build /usr/local/etc/trojan \
    && tar -zxvf trojan.tar.gz -C trojan --strip-components 1 \
    && (cd trojan/build && cmake .. && make ) \
    && mv trojan/build/trojan /usr/bin/trojan \
    && mv trojan/examples/server.json-example /usr/local/etc/trojan/config.json \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && runDeps="$( \
        scanelf --needed --nobanner /usr/bin/trojan \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | xargs -r apk info --installed \
            | sort -u \
        )" \
    && apk add --virtual .run-deps $runDeps \
    && apk del .build-deps .build-deps-kernel \
    && rm -rf /linux-headers-4.4.6-r2.apk \
        /trojan* \
        /var/cache/apk/*

EXPOSE 80 443

CMD ["trojan"]
