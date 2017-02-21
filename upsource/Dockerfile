FROM mritd/alpine-glibc:3.5

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

ENV UPSOURCE_VERSION 3.5.3616

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata wget ca-certificates openjdk8-jre \
    && wget https://download.jetbrains.com/upsource/upsource-${UPSOURCE_VERSION}.zip \
    && unzip upsource-${UPSOURCE_VERSION}.zip \
    && rm -f upsource-${UPSOURCE_VERSION}.zip \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del wget \
    && rm -rf /var/cache/apk/*

WORKDIR upsource-${UPSOURCE_VERSION}/bin

CMD ["/bin/bash"]
