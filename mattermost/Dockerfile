FROM alpine:3.10

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ} 
ENV MATTERMOST_VERSION 5.14.0
ENV MATTERMOST_HOME /mattermost
ENV MATTERMOST_DATA_DIR /data
ENV MATTERMOST_DOWNLOAD_URL https://releases.mattermost.com/${MATTERMOST_VERSION}/mattermost-team-${MATTERMOST_VERSION}-linux-amd64.tar.gz

ENV PATH ${PATH}:${MATTERMOST_HOME}/bin

RUN set -ex \
    && apk upgrade \
    && apk add bash tzdata curl ca-certificates \
        libc6-compat libffi-dev mailcap \
    && curl -s ${MATTERMOST_DOWNLOAD_URL} | tar -xz \
    && ln -s ${MATTERMOST_DATA_DIR} ${MATTERMOST_HOME}/data \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf ${MATTERMOST_HOME}/bin/platform \
            /var/cache/apk/*

WORKDIR ${MATTERMOST_HOME}

VOLUME ${MATTERMOST_DATA_DIR}

EXPOSE 8065

CMD ["mattermost"]
