FROM docker:18.09.6

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

ENV KUBE_VERSION v1.14.3
ENV KUBECTL_DOWNLOAD_URL https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl

RUN apk upgrade --update \
    && apk add bash curl tzdata wget ca-certificates git \
    && wget -q ${KUBECTL_DOWNLOAD_URL} -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

CMD ["/bin/bash"]
