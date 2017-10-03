FROM node:8.6.0-alpine 

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV JAVA_ALPINE_VERSION 8.144.01-r0
ENV MAVEN_VERSION 3.5.0
ENV MAVEN_LOCAL_REPO /data/repo
ENV MAVEN_HOME /usr/lib/maven/default-maven
ENV MAVEN_DOWNLOAD_URL http://mirror.cogentco.com/pub/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz

RUN echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories \
    && apk add --update \
        bash \
        curl \
        tar \
        wget \
        file \
        nasm \
        gcc \
        g++ \
        make \
        python \
        autoconf \
        automake \
        ttf-dejavu \
        openjdk8-jre-base@edge=${JAVA_ALPINE_VERSION} \
        openjdk8-jre-lib@edge=${JAVA_ALPINE_VERSION} \
        openjdk8-jre@edge=${JAVA_ALPINE_VERSION} \
        openjdk8@edge=${JAVA_ALPINE_VERSION} \
        ca-certificates \
        font-adobe-100dpi \
    && mkdir -p ${MAVEN_HOME} ${MAVEN_LOCAL_REPO} \
    && wget ${MAVEN_DOWNLOAD_URL} \
    && tar -zxf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C ${MAVEN_HOME} --strip-components=1 \
    && ln -s ${JAVA_HOME}/bin/* /usr/local/bin \
    && ln -s ${MAVEN_HOME}/bin/* /usr/local/bin \
    && rm -rf apache-maven-${MAVEN_VERSION}-bin.tar.gz \
            /usr/local/bin/*.bat \
            ${MAVEN_HOME}/bin/*.bat \
            /var/cache/apk/* \
            /tmp/*

COPY settings.xml ${MAVEN_HOME}/conf/settings.xml

CMD ["bash"]
