FROM alpine:3.5

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'
ENV MATTERMOST_VERSION 3.8.2

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata wget ca-certificates \
    && wget --no-check-certificate https://releases.mattermost.com/${MATTERMOST_VERSION}/mattermost-${MATTERMOST_VERSION}-linux-amd64.tar.gz \
    && tar -xzf mattermost*.gz \
    && mv mattermost /usr/local/mattermost \
    && mkdir /usr/local/mattermost/data \
    && mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 \ 
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -f mattermost-${MATTERMOST_VERSION}-linux-amd64.tar.gz \
    && rm -rf /var/cache/apk/*

WORKDIR /usr/local/mattermost

CMD ["bin/platform"]
