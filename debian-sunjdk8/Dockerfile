FROM debian:stretch-slim

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV JAVA_VERSION 8
ENV JAVA_UPDATE 191
ENV JAVA_BUILD 12
ENV JAVA_PATH 2787e4a523244c269598db4e85c51e0c
ENV JAVA_HOME /usr/lib/jvm/default-jvm
ENV JAVA_DOWNLOAD_URL http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${JAVA_PATH}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz
ENV JCE_DOWNLOAD_URL http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION}/jce_policy-${JAVA_VERSION}.zip

RUN apt update -y \
    && apt upgrade -y \
    && apt install wget tar unzip tzdata locales -y \
    && wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" ${JAVA_DOWNLOAD_URL} \
    && tar -xzf jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz \
    && mkdir -p /usr/lib/jvm \
    && mv jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE} /usr/lib/jvm/java-${JAVA_VERSION}-oracle \
    && ln -s /usr/lib/jvm/java-${JAVA_VERSION}-oracle ${JAVA_HOME} \
    && ln -s ${JAVA_HOME}/bin/* /usr/bin/ \
    && wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" ${JCE_DOWNLOAD_URL} \
    && unzip -jo -d ${JAVA_HOME}/jre/lib/security jce_policy-${JAVA_VERSION}.zip \
    && locale-gen --purge en_US.UTF-8 zh_CN.UTF-8 \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && echo -e 'LANG="en_US.UTF-8"' > /etc/default/locale \
    && echo -e 'LANGUAGE="en_US:en"' >> /etc/default/locale \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && rm -rf   jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz \
                ${JAVA_HOME}/*src.zip \
                jce_policy-${JAVA_VERSION}.zip \
                ${JAVA_HOME}/jre/lib/security/README.txt \
                /tmp/*

CMD ["bash"]
