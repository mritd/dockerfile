FROM alpine:3.12

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

ENV INSTALL_DIR /opt/yearning
ENV DOWNLOAD_URL https://github.com/cookieY/Yearning/releases/download/v2.2.2/Yearning-2.2.2-4kstars.linux-amd64-patch-1.zip

WORKDIR ${INSTALL_DIR}

RUN set -ex \
    && apk upgrade \
    && apk add bash tzdata ca-certificates libc6-compat wget unzip \
    && wget ${DOWNLOAD_URL} -O yearning.zip \
    && unzip yearning.zip \
    && mv Yearning-go/Yearning ./yearning \
    && mv Yearning-go/dist ./dist \
    && mv Yearning-go/conf.toml ./conf.toml \
    && chmod +x ./yearning \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del wget unzip \
    && rm -rf Yearning-go yearning.zip __MACOSX /var/cache/apk/*

EXPOSE 8000

ENTRYPOINT ["/opt/yearning/yearning"]

CMD ["-m","-s"]
