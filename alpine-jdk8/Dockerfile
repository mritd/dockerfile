FROM mritd/alpine-glibc:3.6 

LABEL maintainer="mritd <mritd@mritd.me>"

ENV JAVA_VERSION 8
ENV JAVA_UPDATE 144
ENV JAVA_BUILD 01
ENV JAVA_PATH 090f390dda5b47b9b721c7dfaa008135 
ENV JAVA_HOME /usr/local/jvm/default-jvm
ENV JAVA_DOWNLOAD_URL http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${JAVA_PATH}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz 
ENV JCE_DOWNLOAD_URL http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION}/jce_policy-${JAVA_VERSION}.zip

RUN apk add --no-cache bash tar wget ca-certificates unzip \
    && mkdir -p ${JAVA_HOME} \
    && wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" ${JAVA_DOWNLOAD_URL} \
    && tar -xzf jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz -C ${JAVA_HOME} --strip-components=1 \
    && wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" ${JCE_DOWNLOAD_URL} \
    && unzip -jo -d ${JAVA_HOME}/jre/lib/security jce_policy-${JAVA_VERSION}.zip \
    && ln -s ${JAVA_HOME}/bin/* /usr/bin/ \
    && apk del tar wget ca-certificates unzip \
    && rm -rf   jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz \
                ${JAVA_HOME}/*src.zip \
                ${JAVA_HOME}/jre/lib/security/README.txt \
                jce_policy-${JAVA_VERSION}.zip \
                /tmp/*
