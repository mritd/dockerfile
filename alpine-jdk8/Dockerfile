FROM mritd/alpine-glibc:3.6 

LABEL maintainer="mritd <mritd@mritd.me>"

ENV JAVA_VERSION 8
ENV JAVA_UPDATE 144
ENV JAVA_BUILD 01
ENV JAVA_PATH 090f390dda5b47b9b721c7dfaa008135 
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
    && rm -rf "${JAVA_HOME}/jre/lib/security/README.txt" \
                "jce_policy-${JAVA_VERSION}.zip" \
                "/tmp/"*
