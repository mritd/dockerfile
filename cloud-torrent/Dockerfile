FROM alpine:3.10

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV CT_VERSION 0.8.25
ENV CT_DOWNLOAD_URL https://github.com/jpillora/cloud-torrent/releases/download/${CT_VERSION}/cloud-torrent_linux_amd64.gz 

RUN apk upgrade --update \
    && apk add bash tzdata wget gzip ca-certificates \
    && wget ${CT_DOWNLOAD_URL} \
    && gzip -d cloud-torrent_linux_amd64.gz \
    && mv cloud-torrent_linux_amd64 /usr/local/bin/cloud-torrent \
    && chmod +x /usr/local/bin/cloud-torrent \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del wget gzip ca-certificates \
    && rm -rf /var/cache/apk/*

CMD ["cloud-torrent"]
