FROM openjdk:8-jdk-alpine 

LABEL maintainer="mritd <mritd@mritd.me>"

ENV TZ 'Asia/Shanghai'
ENV GRADLE_HOME /usr/local/gradle
ENV GRADLE_VERSION 4.0.1
ENV GRADLE_DOWNLOAD_SHA256 d717e46200d1359893f891dab047fdab98784143ac76861b53c50dbd03b44fd4
ENV GRADLE_DOWNLOAD_URL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip

RUN apk upgrade --update \
    && apk add bash tzdata libstdc++ \
    && apk add --virtual .build-deps \
            wget \
            ca-certificates \
            openssl \
            unzip \
    && wget ${GRADLE_DOWNLOAD_URL} \
    && echo "${GRADLE_DOWNLOAD_SHA256}  gradle-${GRADLE_VERSION}-bin.zip" | sha256sum -c - \
    && mkdir -p ${GRADLE_HOME} \
    && unzip -jo -d ${GRADLE_HOME} gradle-${GRADLE_VERSION}-bin.zip \
    && ln -s ${GRADLE_HOME}/bin/gradle /usr/local/bin/gradle \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && addgroup -S -g 1000 gradle \
    && adduser -D -S -G gradle -u 1000 -s /bin/bash gradle \
    && mkdir -p /home/gradle/.gradle \
    && chown -R gradle:gradle /home/gradle \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del .build-deps \
    && rm -rf gradle-${GRADLE_VERSION}-bin.zip /var/cache/apk/*

USER gradle

CMD ["/bin/bash"]
