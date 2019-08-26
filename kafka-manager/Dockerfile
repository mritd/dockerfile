FROM hseeberger/scala-sbt:8u212_1.2.8_2.13.0 AS builder

ENV VERSION 2.0.0.2
ENV DOWNLOAD_URL https://github.com/yahoo/kafka-manager/archive/${VERSION}.tar.gz

RUN set -ex \
    && apt update \
    && apt install tar unzip curl fakeroot -y \
    && curl -sSL ${DOWNLOAD_URL} > km.tar.gz \
    && tar -zxf km.tar.gz \
    && (cd kafka-manager-${VERSION} \
    && sbt clean dist \
    && mv target/universal/kafka-manager-${VERSION}.zip /)

FROM gozap/openjdk8 AS dist

LABEL maintainer="mritd <mritd@linux.com>"

ENV VERSION 2.0.0.2
ENV KAFKA_MANAGER_HOME /usr/local/kafka-manager

COPY --from=builder /kafka-manager-${VERSION}.zip /kafka-manager-${VERSION}.zip

RUN set -ex \
    && unzip kafka-manager-${VERSION}.zip \
    && mv kafka-manager-${VERSION} ${KAFKA_MANAGER_HOME} \
    && rm -f /kafka-manager-${VERSION}.zip

WORKDIR ${KAFKA_MANAGER_HOME}

EXPOSE 9000

ENTRYPOINT ["tini","--"]

CMD ["./bin/kafka-manager"]
