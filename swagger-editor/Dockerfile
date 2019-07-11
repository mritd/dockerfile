FROM nginx:1.17.1-alpine

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

ENV SWAGGERUI_VERSION 3.6.1
ENV SWAGGERUI_DOWNLOAD_URL https://github.com/swagger-api/swagger-editor/archive/v${SWAGGERUI_VERSION}.tar.gz

RUN apk upgrade --update \
    && apk add bash tzdata tar wget ca-certificates \
    && wget ${SWAGGERUI_DOWNLOAD_URL} \
    && tar -zxf v${SWAGGERUI_VERSION}.tar.gz \
    && mv swagger-editor-${SWAGGERUI_VERSION}/index.html /usr/share/nginx/html \
    && mv swagger-editor-${SWAGGERUI_VERSION}/dist /usr/share/nginx/html/dist \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del wget curl tar ca-certificates \
    && rm -rf v${SWAGGERUI_VERSION}.tar.gz \
            swagger-editor-${SWAGGERUI_VERSION} \
            /var/cache/apk/*

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
