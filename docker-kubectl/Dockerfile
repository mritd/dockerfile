FROM docker:dind 

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

ENV KUBE_VERSION v1.10.1
ENV KUBECTL_DOWNLOAD_URL https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl

RUN apk upgrade --update \
    && apk add bash tzdata wget ca-certificates \
    && wget ${KUBECTL_DOWNLOAD_URL} -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

CMD ["/bin/bash"]
