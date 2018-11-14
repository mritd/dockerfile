FROM alpine:3.8

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV TELEPORT_VERSION v3.0.1
ENV TELEPORT_DOWNLOAD_URL https://get.gravitational.com/teleport-${TELEPORT_VERSION}-linux-amd64-bin.tar.gz

RUN apk upgrade \
    && apk add bash tzdata libc6-compat wget tar ca-certificates \
    && wget ${TELEPORT_DOWNLOAD_URL} \
    && tar -zxvf teleport-${TELEPORT_VERSION}-linux-amd64-bin.tar.gz \
    && mv teleport/tctl teleport/teleport teleport/tsh /usr/bin \
    && mkdir /etc/teleport \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del wget tar \
    && rm -rf /*.tar.gz /teleport /var/cache/apk/*

COPY teleport.yaml /etc/teleport/teleport.yaml

VOLUME /var/lib/teleport /etc/teleport

EXPOSE 3022-3026 3080

CMD ["teleport","start","-c","/etc/teleport/teleport.yaml"]
