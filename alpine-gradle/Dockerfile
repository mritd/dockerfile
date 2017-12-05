FROM openjdk:8-jdk-alpine 

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}
ENV GRADLE_HOME /usr/local/gradle
ENV GRADLE_USER_HOME /data/gradle
ENV GRADLE_VERSION 4.3.1
ENV GRADLE_DOWNLOAD_SHA256 15ebe098ce0392a2d06d252bff24143cc88c4e963346582c8d88814758d93ac7
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
    && unzip gradle-${GRADLE_VERSION}-bin.zip \
    && mv gradle-${GRADLE_VERSION} ${GRADLE_HOME} \
    && ln -s ${GRADLE_HOME}/bin/gradle /usr/local/bin/gradle \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del .build-deps \
    && rm -rf gradle-${GRADLE_VERSION}-bin.zip /var/cache/apk/*

CMD ["/bin/bash"]
