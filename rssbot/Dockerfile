FROM alpine:3.12

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

ENV VERSION 2.0.0-alpha.7
ENV DOWNLOAD_URL https://github.com/iovxw/rssbot/releases/download/v${VERSION}/rssbot-en-amd64-linux
ENV MIN_INTERVAL 300
ENV MAX_INTERVAL 43200

ADD ${DOWNLOAD_URL} /usr/local/bin/rssbot

RUN set -ex \
    && apk add tzdata ca-certificates \
    && chmod +x /usr/local/bin/rssbot \
    && rssbot -V \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

VOLUME /data

CMD ["sh", "-c", "rssbot --database /data/data.json --min-interval ${MIN_INTERVAL} --max-interval ${MAX_INTERVAL} ${TELEGRAM_BOT_TOKEN}"]
