FROM alpine:3.10

LABEL maintainer="mritd <mritd@linux.com>"

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --no-cache && \
    apk add --no-cache bash tzdata && \
    mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    rm -rf /var/cache/apk/*

ADD kingshard /root/kingshard

ADD ks.yaml /etc/ks.yaml

CMD ["/root/kingshard"]
