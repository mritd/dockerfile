FROM node:lts-alpine AS builder

ENV SOURCE_DOWNLOAD_ADDR https://github.com/thx/rap2-delos/archive/master.zip

RUN set -ex \
    && apk add curl unzip \
    && curl -sSL ${SOURCE_DOWNLOAD_ADDR} > master.zip \
    && unzip master.zip \
    && yarn global add typescript \
    && (cd rap2-delos-master \
    && yarn install \
    && yarn run build)

FROM node:lts-alpine AS dist

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

RUN apk upgrade \
    && apk add bash tzdata \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY --from=builder /rap2-delos-master/dist/ /app
COPY --from=builder /rap2-delos-master/node_modules /app/node_modules
COPY entrypoint.sh /entrypoint.sh

VOLUME /data

CMD ["/entrypoint.sh"]
