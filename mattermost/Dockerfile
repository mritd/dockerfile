FROM alpine:3.6

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ} 
ENV MATTERMOST_VERSION 4.2.0 

RUN apk upgrade --update \
    && apk add bash tzdata wget ca-certificates \
    && wget --no-check-certificate https://releases.mattermost.com/${MATTERMOST_VERSION}/mattermost-${MATTERMOST_VERSION}-linux-amd64.tar.gz \
    && tar -xzf mattermost*.gz \
    && mv mattermost /usr/local/mattermost \
    && mkdir /data /lib64 \
    && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 \
    && ln -s /data /usr/local/mattermost/data \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf mattermost-${MATTERMOST_VERSION}-linux-amd64.tar.gz \
            /var/cache/apk/*

WORKDIR /usr/local/mattermost/bin

EXPOSE 8065

CMD ["./platform"]
