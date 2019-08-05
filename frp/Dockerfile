FROM alpine:3.10

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}
ENV VERSION 0.28.0
ENV DOWNLOAD_URL https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_amd64.tar.gz

RUN apk upgrade --update \
    && apk add bash tzdata curl \
    && curl -sSLO ${DOWNLOAD_URL} \
    && tar -zxf frp_${VERSION}_linux_amd64.tar.gz \
    && rm -f frp_${VERSION}_linux_amd64/LICENSE \
    && mv frp_${VERSION}_linux_amd64/*.ini /etc \
    && mv frp_${VERSION}_linux_amd64/* /usr/bin \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && apk del curl \
    && rm -rf frp_${VERSION}_linux_amd64.tar.gz \
        frp_${VERSION}_linux_amd64 \
        /var/cache/apk/*

CMD ["frps","-c","/etc/frps.ini"]
