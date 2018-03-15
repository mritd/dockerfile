FROM nginx:1.13.9-alpine

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV TAIGA_FRONT_VERSION 3.1.3
ENV TAIGA_FORNT_DOWNLOAD_URL https://github.com/taigaio/taiga-front-dist/archive/${TAIGA_FRONT_VERSION}-stable.tar.gz

RUN apk upgrade --update \
    && apk add bash tzdata wget ca-certificates \
    && wget ${TAIGA_FORNT_DOWNLOAD_URL} \
    && tar -zxvf ${TAIGA_FRONT_VERSION}-stable.tar.gz \
    && mv taiga-front-dist-${TAIGA_FRONT_VERSION}-stable /usr/local/taiga-front \
    && chown -R nginx:nginx /usr/local/taiga-front \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del wget ca-certificates \
    && rm -rf ${TAIGA_FRONT_VERSION}-stable.tar.gz \
            /var/cache/apk/*

CMD ["nginx", "-g", "daemon off;"]
