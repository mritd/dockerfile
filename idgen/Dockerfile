FROM frolvlad/alpine-glibc

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV IDGEN_VERSION v0.0.3
ENV IDGEN_DOWNLOAD_URL https://github.com/mritd/idgen/releases/download/${IDGEN_VERSION}/idgen-linux-amd64

RUN apk upgrade --update \
    && apk add bash tzdata wget ca-certificates \
    && wget ${IDGEN_DOWNLOAD_URL} -O /usr/local/bin/idgen \
    && chmod +x /usr/local/bin/idgen \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del wget \
    && rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh

EXPOSE 8080

CMD ["/entrypoint.sh"]
