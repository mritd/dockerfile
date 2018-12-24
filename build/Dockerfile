FROM debian:stretch

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV NVM_VERSION 0.33.11
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 10.14.2
ENV JDK_VERSION 11.0.1-open
ENV OPENJDK_VERSION 8.0.192-zulu
ENV ORACLEJDK_VERSION 8.0.191-oracle
ENV NPM_CACHE_DIR /data/npm_cache
ENV NPM_REGISTRY https://registry.npm.taobao.org
ENV MAVEN_CACHE_DIR /data/maven_cache
ENV GRADLE_CACHE_DIR /data/gradle_cache
ENV GRADLE_USER_HOME ${GRADLE_CACHE_DIR}
ENV SDKMAN_DIR /usr/local/sdkman
ENV SDKMAN_INSTALL_URL https://get.sdkman.io
ENV NVM_INSTALL_URL https://raw.githubusercontent.com/creationix/nvm/v${NVM_VERSION}/install.sh

SHELL ["/bin/bash", "-c"]

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install curl wget tar unzip zip bzip2 \
        tzdata git make gcc g++ libpng-dev locales -y \
    && locale-gen --purge en_US.UTF-8 zh_CN.UTF-8 \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && echo -e 'LANG="en_US.UTF-8"' > /etc/default/locale \
    && echo -e 'LANGUAGE="en_US:en"' >> /etc/default/locale \
    && mkdir -p ${NVM_DIR} ${NPM_CACHE_DIR} \
        ${MAVEN_CACHE_DIR} ${GRADLE_CACHE_DIR} \
    && curl -s ${NVM_INSTALL_URL} | bash \
    && curl -s ${SDKMAN_INSTALL_URL} | bash \
    && source ~/.bashrc \
    && sdk install maven \
    && sdk install gradle \
    && sdk install java ${JDK_VERSION} \
    && sdk install java ${ORACLEJDK_VERSION} \
    && sdk install java ${OPENJDK_VERSION} \
    && npm install -g npm yarn node-gyp gulp \
    && npm install -g --unsafe-perm build-tools \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf ~/.npm /var/lib/apt/lists/* /tmp/*

COPY sdkconfig ${SDKMAN_DIR}/etc/config
COPY cnpm /usr/bin/cnpm
COPY cyarn /usr/bin/cyarn
COPY cmvn /usr/bin/cmvn
COPY entrypoint.sh /entrypoint.sh

VOLUME ${NPM_CACHE_DIR}
VOLUME ${MAVEN_CACHE_DIR}
VOLUME ${GRADLE_CACHE_DIR}

ENTRYPOINT ["/entrypoint.sh"]

CMD ["bash"]
