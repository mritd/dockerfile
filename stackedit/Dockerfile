FROM node:9.11.1-alpine as builder

ENV STACKEDIT_VERSION 5.11.0
ENV STACKEDIT_DOWNLOAD_URL https://github.com/benweet/stackedit/archive/v${STACKEDIT_VERSION}.tar.gz

RUN apk upgrade --update \
    && apk add wget tar \
    && wget stackedit-${STACKEDIT_DOWNLOAD_URL} \
    && tar -zxvf ${STACKEDIT_VERSION}.tar.gz \
    && (cd ${STACKEDIT_VERSION} \
    && npm install \
    && npm run build)



FROM nginx:1.13.12-alpine

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV STACKEDIT_VERSION 5.11.0

RUN apk upgrade --update \
    && apk add bash tzdata \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /usr/share/nginx/html \
                /var/cache/apk/*

COPY --from=builder /stackedit-${STACKEDIT_VERSION}/dist /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
