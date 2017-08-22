FROM openjdk:8-jre-alpine

LABEL maintainer="mritd <mritd1234@gmail.com>"

# https://artifacts.elastic.co/GPG-KEY-elasticsearch
ENV GPG_KEY 46095ACC8548582C1A2699A9D27D666CD88E42B4
ENV ELASTICSEARCH_VERSION 5.5.1
ENV ELASTICSEARCH_HOME /usr/local/elasticsearch
ENV ELASTICSEARCH_TARBALL https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz
ENV ELASTICSEARCH_TARBALL_ASC https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz.asc
ENV ELASTICSEARCH_TARBALL_SHA1 cb5648a6723527bdccee98caef7a9d08885a5b0f

# ensure elasticsearch user exists
RUN set -ex \
    && addgroup -S elasticsearch \
    && adduser -S -G elasticsearch elasticsearch \
    && apk upgrade --update \
    # grab su-exec for easy step-down from root
    # and bash for "bin/elasticsearch" among others
    && apk add 'su-exec>=0.2' bash tzdata \
    && apk add --virtual .fetch-deps \
        ca-certificates \
        gnupg \
        openssl \
        tar \
    && wget -O elasticsearch.tar.gz "$ELASTICSEARCH_TARBALL" \
    && wget -O elasticsearch.tar.gz.asc "$ELASTICSEARCH_TARBALL_ASC" \
    && echo "$ELASTICSEARCH_TARBALL_SHA1 *elasticsearch.tar.gz" | sha1sum -c - \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
    && gpg --batch --verify elasticsearch.tar.gz.asc elasticsearch.tar.gz \
    && tar -zxf elasticsearch.tar.gz \
    && mv elasticsearch-${ELASTICSEARCH_VERSION} ${ELASTICSEARCH_HOME} \
    && mkdir -p /data/elasticsearch /var/log/elasticsearch \
    && chown -R elasticsearch:elasticsearch ${ELASTICSEARCH_HOME} /data/elasticsearch /var/log/elasticsearch \
    && ln -sf ${ELASTICSEARCH_HOME}/bin/* /usr/local/bin \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del .fetch-deps \
    && rm -rf "$GNUPGHOME" \
        elasticsearch.tar.gz.asc \
        elasticsearch.tar.gz \
        ${ELASTICSEARCH_HOME}/bin/*.exe \
        ${ELASTICSEARCH_HOME}/bin/*.bat \
    && rm -rf /var/cache/apk/*

COPY config ${ELASTICSEARCH_HOME}/config

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME /data/elasticsearch 

EXPOSE 9200 9300

ENTRYPOINT ["/entrypoint.sh"]

CMD ["elasticsearch"]
