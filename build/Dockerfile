FROM openjdk:8u151-jdk

MAINTAINER mritd <mritd1234@gmail.com>

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}
ENV INSTALL_BASE_DIR /usr/local

ENV MAVEN_VERSION 3.5.3
ENV MAVEN_LOCAL_REPO /data/maven
ENV MAVEN_HOME ${INSTALL_BASE_DIR}/maven/default-maven
ENV MAVEN_DOWNLOAD_URL http://mirror.cogentco.com/pub/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz

ENV GRADLE_VERSION 4.6
ENV GRADLE_USER_HOME /data/gradle
ENV GRADLE_HOME ${INSTALL_BASE_DIR}/gradle/default-gradle
ENV GRADLE_DOWNLOAD_URL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install wget tar unzip tzdata git make gcc g++ libpng-dev -y \
    && mkdir -p ${MAVEN_HOME} ${MAVEN_LOCAL_REPO} ${GRADLE_HOME} ${GRADLE_USER_HOME} \
    && wget ${MAVEN_DOWNLOAD_URL} ${GRADLE_DOWNLOAD_URL} \
    && wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash \
    && tar -zxf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C ${MAVEN_HOME} --strip-components=1 \
    && unzip -jo -d ${GRADLE_HOME} gradle-${GRADLE_VERSION}-bin.zip \
    && ln -s ${MAVEN_HOME}/bin/* /usr/local/bin \
    && ln -s ${GRADLE_HOME}/bin/* /usr/local/bin \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && rm -rf apache-maven-${MAVEN_VERSION}-bin.tar.gz \
            gradle-${GRADLE_VERSION}-bin.zip \
            /usr/local/bin/*.bat \
            ${MAVEN_HOME}/bin/*.bat \
            ${GRADLE_HOME}/bin/*.bat \
            /tmp/*

COPY cnpm /usr/local/bin/cnpm
COPY settings.xml ${MAVEN_HOME}/conf/settings.xml
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
