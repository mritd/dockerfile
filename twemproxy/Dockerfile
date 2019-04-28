FROM alpine:3.8

ENV TWEMPROXY_VERSION 0.4.1
ENV TWEMPROXY_CONFIG_DIR /etc/twemproxy
ENV TWEMPROXY_DOWNLOAD_URL https://github.com/twitter/twemproxy/archive/v${TWEMPROXY_VERSION}.tar.gz

RUN apk upgrade --update \
 	&& apk add libtool build-base make automake autoconf wget ca-certificates \
 	&& wget ${TWEMPROXY_DOWNLOAD_URL} -O twemproxy.tar.gz \
 	&& tar -zxvf twemproxy.tar.gz \
 	&& (cd twemproxy-${TWEMPROXY_VERSION} \
 	&& autoreconf -fvi \
 	&& ./configure --prefix=/ \
 	&& make -j2 \
 	&& make install)

FROM alpine:3.8

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV TWEMPROXY_VERSION 0.4.1
ENV TWEMPROXY_CONFIG_DIR /etc/twemproxy

RUN apk upgrade --update \
    && apk add bash tzdata \
    && mkdir ${TWEMPROXY_CONFIG_DIR} \ 
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY --from=0 /sbin/nutcracker /sbin/
COPY config.yml ${TWEMPROXY_CONFIG_DIR}
COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
