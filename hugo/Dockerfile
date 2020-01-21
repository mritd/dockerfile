FROM golang:1.13.6-alpine3.11 AS builder

ENV GO111MODULE on
ENV GOPROXY https://goproxy.io
ENV GOSUMDB sum.golang.google.cn

RUN go get -u github.com/mritd/httpcmd

FROM nginx:1.17.6-alpine

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"
ARG HTTPCMD_TOKEN=""

ENV TZ ${TZ}
ENV HTTPCMD_TOKEN ${HTTPCMD_TOKEN}

RUN apk upgrade \
    && apk add bash git tzdata \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /usr/share/nginx/html /var/cache/apk/*

COPY --from=builder /go/bin/httpcmd /usr/local/bin/httpcmd
COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
