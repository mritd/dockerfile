FROM alpine:3.7

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ} 
ENV PATH ${PATH}:/mattermost/bin
ENV MATTERMOST_VERSION 4.6.1
ENV MATTERMOST_DOWNLOAD_URL https://releases.mattermost.com/${MATTERMOST_VERSION}/mattermost-${MATTERMOST_VERSION}-linux-amd64.tar.gz

RUN apk upgrade --update \
    && apk add bash tzdata wget ca-certificates \
        libc6-compat libffi-dev mailcap \
    && wget ${MATTERMOST_DOWNLOAD_URL} \
    && tar -xzf mattermost*.gz \
    && mv mattermost / \
    && mkdir /data \
    && ln -s /data /mattermost/data \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf mattermost-${MATTERMOST_VERSION}-linux-amd64.tar.gz \
            /var/cache/apk/*

WORKDIR /mattermost/bin

VOLUME /data

EXPOSE 8065

CMD ["./platform"]
