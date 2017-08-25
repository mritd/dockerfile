FROM openjdk:8-jdk-alpine 

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TZ 'Asia/Shanghai'
ENV GRADLE_HOME /usr/local/gradle
ENV GRADLE_USER_HOME /data/gradle
ENV GRADLE_VERSION 4.0.1
ENV GRADLE_DOWNLOAD_SHA256 d717e46200d1359893f891dab047fdab98784143ac76861b53c50dbd03b44fd4
ENV GRADLE_DOWNLOAD_URL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
ENV SDK_HOME /usr/local/android
ENV SDK_TOOLS_HOME /usr/local/sdktools
ENV SDK_TOOLS_VERSION 3859397
ENV SDK_TOOLS_DOWNLOAD_URL https://dl.google.com/android/repository/sdk-tools-linux-${SDK_TOOLS_VERSION}.zip

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
    && wget ${SDK_TOOLS_DOWNLOAD_URL} \
    && unzip sdk-tools-linux-${SDK_TOOLS_VERSION}.zip \
    && mkdir ${SDK_HOME} \
    && mv tools ${SDK_TOOLS_HOME} \
    && ln -s ${SDK_TOOLS_HOME}/bin/* /usr/local/bin \
    && yes | sdkmanager --licenses --sdk_root=${SDK_HOME} \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del .build-deps \
    && rm -rf   gradle-${GRADLE_VERSION}-bin.zip \
                sdk-tools-linux-${SDK_TOOLS_VERSION}.zip \
                /var/cache/apk/*

CMD ["/bin/bash"]
