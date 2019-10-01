FROM golang:1.13.1-alpine3.10 AS builder

ENV GO111MODULE on
ENV GOPROXY https://goproxy.io
ENV GOSUMDB sum.golang.google.cn

RUN apk upgrade \
    && apk add git \
    && go get github.com/shadowsocks/go-shadowsocks2

FROM alpine:3.10 AS dist

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
