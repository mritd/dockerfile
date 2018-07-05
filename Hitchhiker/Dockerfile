FROM node:8.11.3-alpine

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV HITCHHIKER_VERSION v0.13
ENV HITCHHIKER_HOME /Hitchhiker
ENV HITCHHIKER_DOWNLOAD_URL https://github.com/brookshi/Hitchhiker/releases/download/${HITCHHIKER_VERSION}/Hitchhiker.zip

RUN apk upgrade --update \
    && apk add bash tzdata wget ca-certificates unzip \
    && wget ${HITCHHIKER_DOWNLOAD_URL} \
    && mkdir ${HITCHHIKER_HOME} \
    && mv Hitchhiker.zip ${HITCHHIKER_HOME} \
    && (cd ${HITCHHIKER_HOME} \
    && unzip Hitchhiker.zip) \
    && npm install -g pm2 \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del wget unzip \
    && rm -rf ${HITCHHIKER_HOME}/Hitchhiker.zip \
        /var/cache/apk/*

WORKDIR ${HITCHHIKER_HOME}/build

CMD ["pm2-docker","index.js"]
