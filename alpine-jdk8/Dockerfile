FROM mritd/alpine-glibc:3.6 

MAINTAINER mritd <mritd@mritd.me>

ENV JAVA_VERSION 8
ENV JAVA_UPDATE 131
ENV JAVA_BUILD 11
ENV JAVA_PATH d54c1d3a095b4ff2b6607d096fa80163
ENV JAVA_HOME /usr/lib/jvm/default-jvm

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
    && rm -f "${JAVA_HOME}/jre/lib/security/README.txt" \
    && apk del build-dependencies \
    && rm -rf "/tmp/"*
