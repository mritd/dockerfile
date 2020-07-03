FROM golang:1.14.4-alpine3.12 AS builder

ARG VERSION="v2.2.2"

ENV VERSION ${VERSION}
ENV DOWNLOAD_URL https://github.com/cookieY/Yearning/archive/${VERSION}.tar.gz

ENV GO111MODE on
ENV GOPROXY https://goproxy.cn

WORKDIR /go/src/github.com/cookiey/yearning

RUN set -ex \
    && apk add git tar wget \
    && wget ${DOWNLOAD_URL} \
    && tar -zxf ${VERSION}.tar.gz -C . --strip-components=1 \
    && rm -f ${VERSION}.tar.gz \
    && go install

FROM alpine:3.12

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

RUN set -ex \
    && apk upgrade \
    && apk add bash tzdata ca-certificates \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY --from=builder /go/bin/Yearning-go /usr/local/bin/yearning

EXPOSE 8000

ENTRYPOINT ["yearning"]
