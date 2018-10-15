FROM golang:1.11.1-alpine3.8 AS builder

RUN apk upgrade --update \
    && apk add git \
    && go get github.com/etcd-io/zetcd/cmd/...

FROM alpine:3.8

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

RUN apk upgrade --update \
    && apk add bash tzdata \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY --from=builder /go/bin/* /usr/bin/

ENTRYPOINT ["zetcd","--zkaddr","0.0.0.0:2181","--endpoints","0.0.0.0:2379"]
