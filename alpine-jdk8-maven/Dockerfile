FROM mritd/alpine-glibc:3.6 

LABEL maintainer="mritd <mritd@mritd.me>"

ENV JAVA_VERSION 8
ENV JAVA_UPDATE 144
ENV JAVA_BUILD 01
ENV JAVA_PATH 090f390dda5b47b9b721c7dfaa008135 
ENV JAVA_HOME /usr/lib/jvm/default-jvm
ENV MAVEN_HOME /usr/lib/maven/default-maven
ENV MAVEN_VERSION 3.5.0

RUN apk add --no-cache --virtual=build-dependencies wget ca-certificates unzip \
    && wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
        "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${JAVA_PATH}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" \
    && tar -xzf "jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" \
    && rm -f "jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" \
    && mkdir -p "/usr/lib/jvm" \
    && mv "jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}" "/usr/lib/jvm/java-${JAVA_VERSION}-oracle" \
    && ln -s "java-${JAVA_VERSION}-oracle" "$JAVA_HOME" \
    && ln -s "$JAVA_HOME/bin/"* "/usr/bin/" \
    && rm -rf "$JAVA_HOME/"*src.zip \
    && wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
        "http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION}/jce_policy-${JAVA_VERSION}.zip" \
    && unzip -jo -d "${JAVA_HOME}/jre/lib/security" "jce_policy-${JAVA_VERSION}.zip" \
    && wget http://mirror.bit.edu.cn/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && tar -zxf apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && apk del build-dependencies \
    && rm -rf ${JAVA_HOME}/jre/lib/security/README.txt \
              apache-maven-${MAVEN_VERSION}-bin.tar.gz \
              /tmp/*
