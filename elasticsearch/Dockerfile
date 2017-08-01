FROM openjdk:8-jre-alpine

LABEL maintainer="mritd <mritd@mritd.me>"

# https://artifacts.elastic.co/GPG-KEY-elasticsearch
ENV GPG_KEY 46095ACC8548582C1A2699A9D27D666CD88E42B4
ENV PATH /usr/share/elasticsearch/bin:$PATH
ENV ELASTICSEARCH_VERSION 5.5.1
ENV ELASTICSEARCH_HOME /usr/share/elasticsearch
ENV ELASTICSEARCH_TARBALL https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz
ENV ELASTICSEARCH_TARBALL_ASC https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz.asc
ENV ELASTICSEARCH_TARBALL_SHA1 cb5648a6723527bdccee98caef7a9d08885a5b0f
# we shouldn't need much RAM to test --version (default is 2gb, which gets Jenkins in trouble sometimes)
ENV ES_JAVA_OPTS "-Xms32m -Xmx32m"

# ensure elasticsearch user exists
RUN set -ex apk upgrade --update \
    && addgroup -S elasticsearch && adduser -S -G elasticsearch elasticsearch \
    # grab su-exec for easy step-down from root
    # and bash for "bin/elasticsearch" among others
    && apk add --update 'su-exec>=0.2' bash tzdata \
    && apk add --virtual .fetch-deps \
        ca-certificates \
        gnupg \
        openssl \
        tar \
    && wget -O elasticsearch.tar.gz "$ELASTICSEARCH_TARBALL" \
    && echo "$ELASTICSEARCH_TARBALL_SHA1 *elasticsearch.tar.gz" | sha1sum -c - \
    && wget -O elasticsearch.tar.gz.asc "$ELASTICSEARCH_TARBALL_ASC" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
    && gpg --batch --verify elasticsearch.tar.gz.asc elasticsearch.tar.gz \
    && rm -rf "$GNUPGHOME" elasticsearch.tar.gz.asc \
    && tar -zxf elasticsearch.tar.gz \
    && mv elasticsearch-${ELASTICSEARCH_VERSION} ${ELASTICSEARCH_HOME} \
    && rm -f elasticsearch.tar.gz \
    && apk del .fetch-deps \
    && bash -c "mkdir -p ${ELASTICSEARCH_HOME}/{plugins,data,logs}" \
    && chown -R elasticsearch:elasticsearch ${ELASTICSEARCH_HOME} \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY config ${ELASTICSEARCH_HOME}/config

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME /usr/share/elasticsearch/data

EXPOSE 9200 9300

ENTRYPOINT ["/entrypoint.sh"]

CMD ["elasticsearch"]
