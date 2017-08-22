FROM alpine:3.6

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TZ 'Asia/Shanghai'
ENV LGTM_VERSION=0.1.0
ENV LGTM_NOTE=LGTM
ENV LGTM_COUNT=1
ENV LGTM_PORT=8989
ENV LGTM_TOKEN=mp3fzN3b4dBUxn9c
ENV LGTM_GITLAB_URL=https://gitlab.com
ENV LGTM_DB_PATH=/data/lgtm.data
ENV LGTM_LOG_LEVEL=info
ENV LGTM_BINARY_URL=https://github.com/cloverstd/lgtm-gitlab/releases/download/v$LGTM_VERSION/lgtm-alpine-linux-amd64-v$LGTM_VERSION.tar.gz

RUN apk upgrade --update \
    && apk add bash tzdata curl \
    && curl -slL ${LGTM_BINARY_URL} -o lgtm.tar.gz \
    && tar -zxvf lgtm.tar.gz \
    && chmod +x lgtm \
    && mv lgtm /usr/local/bin/lgtm \
    && mkdir /data \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf lgtm.tar.gz /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh

VOLUME /data

EXPOSE 8989

CMD ["/entrypoint.sh"]
