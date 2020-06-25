FROM alpine:3.12

ENV VERSION 2.0.0-alpha.7
ENV DOWNLOAD_URL https://github.com/iovxw/rssbot/releases/download/v${VERSION}/rssbot-en-amd64-linux
ENV MIN_INTERVAL 300
ENV MAX_INTERVAL 43200

ADD ${DOWNLOAD_URL} /rssbot

RUN apk --no-cache add ca-certificates && \
    chmod +x /rssbot && \
    /rssbot -V

VOLUME /data
CMD ["sh", "-c", "/rssbot --database /data/data.json --min-interval ${MIN_INTERVAL} --max-interval ${MAX_INTERVAL} ${TELEGRAM_BOT_TOKEN}"]
