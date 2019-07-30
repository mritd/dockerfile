FROM node:lts-alpine AS builder

ENV VERSION 2.1.4
ENV SOURCE_DOWNLOAD_ADDR https://github.com/thx/rap2-dolores/archive/v${VERSION}.tar.gz

RUN set -ex \
    && apk add curl tar \
    && curl -sSL ${SOURCE_DOWNLOAD_ADDR} > ${VERSION}.tar.gz \
    && tar -zxf ${VERSION}.tar.gz

WORKDIR /rap2-dolores-${VERSION}

COPY config.prod.ts src/config/config.prod.ts

RUN set -ex \
    && npm install \
    && npm run build

FROM nginx:1.17.2-alpine AS dist

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV VERSION 2.1.4

RUN apk upgrade \
    && apk add bash tzdata \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /usr/share/nginx/html /var/cache/apk/*

COPY --from=builder /rap2-dolores-${VERSION}/build /usr/share/nginx/html
COPY nginx.vh.default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
