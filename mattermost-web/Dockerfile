FROM alpine:3.5

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'
ENV MATTERMOST_VERSION 3.6.1

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata wget \
    && wget --no-check-certificate https://releases.mattermost.com/${MATTERMOST_VERSION}/mattermost-${MATTERMOST_VERSION}-linux-amd64.tar.gz \
    && tar -xzf mattermost*.gz \
    && mv mattermost /usr/local/mattermost \
    && mkdir /usr/local/mattermost/data \
    && addgroup -S mattermost \
    && adduser -S mattermost -h /usr/local/mattermost -G mattermost mattermost \
    && chown -R mattermost:mattermost /usr/local/mattermost \
    && mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 \ 
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/*

USER mattermost

WORKDIR /usr/local/mattermost

VOLUME /usr/local/mattermost/config/config.json

CMD ["/bin/bash"]
