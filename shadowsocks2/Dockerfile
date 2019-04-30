FROM golang:1.12.4-alpine3.9 AS builder

RUN apk upgrade --update \
    && apk add git \
    && go get -ldflags '-w -s' \
        github.com/shadowsocks/go-shadowsocks2

FROM alpine:3.9 AS dist

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

RUN apk upgrade --update \
    && apk add tzdata \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY --from=builder /go/bin/go-shadowsocks2 /usr/bin/shadowsocks
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
