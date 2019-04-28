FROM alpine:3.8

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ} 
ENV MATTERMOST_VERSION 5.5.1
ENV MATTERMOST_HOME /mattermost
ENV MATTERMOST_DATA_DIR /data
ENV MATTERMOST_DOWNLOAD_URL https://releases.mattermost.com/${MATTERMOST_VERSION}/mattermost-${MATTERMOST_VERSION}-linux-amd64.tar.gz

RUN apk upgrade \
    && apk add bash tzdata wget ca-certificates \
        libc6-compat libffi-dev mailcap \
    && wget ${MATTERMOST_DOWNLOAD_URL} \
    && tar -xzf mattermost*.gz \
    && mkdir ${MATTERMOST_DATA_DIR} \
    && ln -s ${MATTERMOST_DATA_DIR} ${MATTERMOST_HOME}/data \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf mattermost-${MATTERMOST_VERSION}-linux-amd64.tar.gz \
            ${MATTERMOST_HOME}/bin/platform \
            /var/cache/apk/*

WORKDIR ${MATTERMOST_HOME}/bin

VOLUME ${MATTERMOST_DATA_DIR}

EXPOSE 8065

CMD ["./mattermost","server"]
