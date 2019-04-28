FROM golang:1.10.3-alpine3.8 AS builder

RUN apk upgrade \
    && apk add git \
    && go get github.com/yudai/gotty

FROM alpine:3.8

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV KUBE_VERSION 1.11.2
ENV KUBECTL_DOWNLOAD_URL https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl

RUN apk upgrade \
    && apk add bash tzdata wget ca-certificates \
    && wget ${KUBECTL_DOWNLOAD_URL} -O /usr/bin/kubectl \
    && chmod +x /usr/bin/kubectl \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY --from=builder /go/bin/gotty /usr/bin/gotty

EXPOSE 8080

ENTRYPOINT ["gotty","--once","--timeout","30","--close-timeout","30","--permit-write","bash"]
