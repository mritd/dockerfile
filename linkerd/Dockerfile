FROM openjdk:8u151-jdk-alpine

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}
ENV LINKERD_VERSION 1.3.3 
ENV LINKERD_DOWNLOAD_URL https://github.com/linkerd/linkerd/releases/download/${LINKERD_VERSION}/linkerd-${LINKERD_VERSION}-exec

RUN apk upgrade --update \
    && apk add bash tzdata wget ca-certificates \
    && wget ${LINKERD_DOWNLOAD_URL} -O /usr/local/bin/linkerd \
    && chmod +x /usr/local/bin/linkerd \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY linkerd.yaml /etc/linkerd.yaml

CMD ["linkerd","/etc/linkerd.yaml"]
