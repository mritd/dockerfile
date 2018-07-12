FROM alpine:3.8

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV HITCHHIKER_NODE_VERSION v0.2
ENV HITCHHIKER_NODE_DOWNLOAD_URL https://github.com/brookshi/Hitchhiker-Node/releases/download/${HITCHHIKER_NODE_VERSION}/linux_64.zip

RUN apk upgrade --update \
    && apk add bash tzdata unzip wget ca-certificates \
    && wget ${HITCHHIKER_NODE_DOWNLOAD_URL} \
    && unzip linux_64.zip \
    && mv linux_64/* / \
    && chmod +x Hitchhiker-Node_linux_amd64 \
    && mv /Hitchhiker-Node_linux_amd64 /hitchhiker-node \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del unzip wget ca-certificates \
    && rm -rf /linux_64.zip /var/cache/apk/*

CMD ["./hitchhiker-node"]
