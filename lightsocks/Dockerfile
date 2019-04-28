FROM alpine:3.8

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV LIGHTSOCKS_VERSION 1.0.6
ENV LIGHTSOCKS_DOWNLOAD_URL https://github.com/gwuhaolin/lightsocks/releases/download/${LIGHTSOCKS_VERSION}/lightsocks_${LIGHTSOCKS_VERSION}_linux_amd64.tar.gz

RUN apk upgrade --update \
    && apk add bash tzdata curl tar \
    && curl -sSLO ${LIGHTSOCKS_DOWNLOAD_URL} \
    && tar -zxf lightsocks_${LIGHTSOCKS_VERSION}_linux_amd64.tar.gz \
    && mv lightsocks-local lightsocks-server /usr/local/bin \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del curl tar \
    && rm -rf lightsocks_${LIGHTSOCKS_VERSION}_linux_amd64.tar.gz \
            readme.md \
            /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
