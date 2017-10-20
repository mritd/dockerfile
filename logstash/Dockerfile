FROM openjdk:8-jre-alpine

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV GPG_KEY 46095ACC8548582C1A2699A9D27D666CD88E42B4 
ENV LOGSTASH_VERSION 5.6.3
ENV LOGSTASH_HOME /usr/local/logstash
ENV LOGSTASH_TARBALL https://artifacts.elastic.co/downloads/logstash/logstash-${LOGSTASH_VERSION}.tar.gz 
ENV LOGSTASH_TARBALL_ASC https://artifacts.elastic.co/downloads/logstash/logstash-${LOGSTASH_VERSION}.tar.gz.asc 
ENV LOGSTASH_TARBALL_SHA1 9a47baec72e76eef23d908fae8b94ff3497e569f 

# ensure logstash user exists
RUN set -ex \
    && addgroup -S logstash \
    && adduser -S -G logstash logstash \
    && apk upgrade --update \
    # grab su-exec for easy step-down from root
    # and bash for "bin/logstash" among others
    && apk add 'su-exec>=0.2' bash tzdata \
    && apk add --virtual .fetch-deps \
        ca-certificates \
        gnupg \
        openssl \
        tar \
    && wget -O logstash.tar.gz "${LOGSTASH_TARBALL}" \
    && wget -O logstash.tar.gz.asc "${LOGSTASH_TARBALL_ASC}" \
    && echo "${LOGSTASH_TARBALL_SHA1}  logstash.tar.gz" | sha1sum -c - \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "${GPG_KEY}" \
    && gpg --batch --verify logstash.tar.gz.asc logstash.tar.gz \
    && tar -zxf logstash.tar.gz \
    && mv logstash-${LOGSTASH_VERSION} ${LOGSTASH_HOME} \
    && mkdir -p /data/logstash /var/log/logstash \
    && chown -R logstash:logstash ${LOGSTASH_HOME} /data/logstash /var/log/logstash \
    && ln -sf ${LOGSTASH_HOME}/bin/* /usr/local/bin \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del .fetch-deps \
    && rm -rf "${GNUPGHOME}" \
        logstash.tar.gz.asc \
        logstash.tar.gz \
        ${logstash_HOME}/bin/*.exe \
        ${logstash_HOME}/bin/*.bat \
    && rm -rf /var/cache/apk/*

COPY config ${logstash_HOME}/config

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME /data/logstash /var/log/logstash 

ENTRYPOINT ["/entrypoint.sh"]

CMD ["-e",""]
