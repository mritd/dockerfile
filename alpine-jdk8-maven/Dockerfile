FROM mritd/alpine-glibc:3.6 

LABEL maintainer="mritd <mritd@mritd.me>"

ENV JAVA_VERSION 8
ENV JAVA_UPDATE 144
ENV JAVA_BUILD 01
ENV JAVA_PATH 090f390dda5b47b9b721c7dfaa008135 
ENV JAVA_HOME /usr/local/jvm/default-jvm
ENV JAVA_DOWNLOAD_URL http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${JAVA_PATH}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz
ENV JCE_DOWNLOAD_URL http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION}/jce_policy-${JAVA_VERSION}.zip
ENV MAVEN_VERSION 3.5.0
ENV MAVEN_HOME /usr/local/maven/default-maven
ENV MAVEN_DOWNLOAD_URL http://mirror.bit.edu.cn/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz

RUN apk add --no-cache bash tar wget ca-certificates unzip \
    && mkdir -p ${JAVA_HOME} ${MAVEN_HOME} \
    && wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" ${JAVA_DOWNLOAD_URL} \
    && tar -xzf jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz -C ${JAVA_HOME} --strip-components=1 \
    && wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" ${JCE_DOWNLOAD_URL} \
    && unzip -jo -d ${JAVA_HOME}/jre/lib/security jce_policy-${JAVA_VERSION}.zip \
    && wget ${MAVEN_DOWNLOAD_URL} \
    && tar -zxf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C ${MAVEN_HOME} --strip-components=1 \
    && ln -s ${JAVA_HOME}/bin/* /usr/local/bin \
    && ln -s ${MAVEN_HOME}/bin/mvn /usr/local/bin/mvn \
    && apk del tar wget ca-certificates unzip \
    && rm -rf   jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz \
                ${JAVA_HOME}/*src.zip \
                ${JAVA_HOME}/jre/lib/security/README.txt \
                jce_policy-${JAVA_VERSION}.zip \
                apache-maven-${MAVEN_VERSION}-bin.tar.gz \
                ${MAVEN_HOME}/bin/*.bat \
                /tmp/*

COPY settings.xml ${MAVEN_HOME}/conf/settings.xml

VOLUME /data/repo

CMD ["bash"]
