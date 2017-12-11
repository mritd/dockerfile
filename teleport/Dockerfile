FROM alpine:3.7

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TZ 'Asia/Shanghai'

ENV TELEPORT_VERSION v2.3.5
ENV TELEPORT_DOWNLOAD_URL https://github.com/gravitational/teleport/releases/download/${TELEPORT_VERSION}/teleport-${TELEPORT_VERSION}-linux-amd64-bin.tar.gz

RUN apk upgrade --update \
    && apk add bash tzdata wget tar ca-certificates \
    && wget ${TELEPORT_DOWNLOAD_URL} \
    && tar -zxvf teleport-${TELEPORT_VERSION}-linux-amd64-bin.tar.gz \
    && mv teleport/tctl teleport/teleport teleport/tsh /usr/local/bin \
    && mkdir /etc/teleport /lib64 \
    && ln -sf /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /*.tar.gz /teleport /var/cache/apk/*

COPY teleport.yaml /etc/teleport/teleport.yaml

VOLUME /var/lib/teleport /etc/teleport

EXPOSE 3022-3025 3080

CMD ["teleport","start","-c","/etc/teleport/teleport.yaml"]
