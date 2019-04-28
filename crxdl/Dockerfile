FROM alpine:3.9

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV CRXDL_VERSION 1.0.0
ENV CRXDL_DOWNLOAD_URL https://github.com/mritd/crxdl/releases/download/v${CRXDL_VERSION}/crxdl_linux_amd64

RUN apk upgrade --update \
    && apk add bash tzdata wget ca-certificates \
    && wget ${CRXDL_DOWNLOAD_URL} -O /usr/bin/crxdl \
    && chmod +x /usr/bin/crxdl \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del wget \
    && rm -rf /var/cache/apk/*

EXPOSE 8080

CMD ["crxdl"]
