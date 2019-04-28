FROM openjdk:8u151-jdk-alpine

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}
ENV NAMERD_VERSION 1.3.2
ENV NAMERD_DOWNLOAD_URL https://github.com/linkerd/linkerd/releases/download/${NAMERD_VERSION}/namerd-${NAMERD_VERSION}-exec 

RUN apk upgrade --update \
    && apk add bash tzdata wget ca-certificates \
    && wget ${NAMERD_DOWNLOAD_URL} -O /usr/local/bin/namerd \
    && chmod +x /usr/local/bin/namerd \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY namerd.yaml /etc/namerd.yaml

CMD ["namerd","/etc/namerd.yaml"]
