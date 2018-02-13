FROM alpine:3.7

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV KUBECTL_VERSION 1.8.8
ENV KUBECTL_DOWNLOAD_URL https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl

RUN apk upgrade --update \
    && apk add bash tzdata wget ca-certificates \
    && wget ${KUBECTL_DOWNLOAD_URL} -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && apk del wget ca-certificates \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

ADD kube-addons.sh /opt/
ADD namespace.yaml /opt/

CMD ["/opt/kube-addons.sh"]
