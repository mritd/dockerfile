FROM debian:stretch

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV NVM_VERSION 0.33.8
ENV NODE_VERSION 8.11.1
ENV OPENJDK_VERSION 8.0.163-zulu
ENV ORACLEJDK_VERSION 8.0.161-oracle
ENV SDKMAN_INSTALL_URL https://get.sdkman.io
ENV NVM_INSTALL_URL https://raw.githubusercontent.com/creationix/nvm/v${NVM_VERSION}/install.sh

SHELL ["/bin/bash", "-c"]

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install curl wget tar unzip zip tzdata \
        git make gcc g++ libpng-dev locales -y \
    && locale-gen --purge en_US.UTF-8 zh_CN.UTF-8 \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && echo -e 'LANG="en_US.UTF-8"' > /etc/default/locale \
    && echo -e 'LANGUAGE="en_US:en"' >> /etc/default/locale \
    && curl -s ${NVM_INSTALL_URL} | bash \
    && curl -s ${SDKMAN_INSTALL_URL} | bash \
    && source ~/.bashrc \
    && sdk install maven \
    && sdk install gradle \
    && sdk install java ${ORACLEJDK_VERSION} \
    && sdk install java ${OPENJDK_VERSION} \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/lib/apt/lists/* /tmp/*

COPY sdkconfig /root/.sdkman/etc/config
COPY cnpm /usr/local/bin/cnpm
COPY cmvn /usr/local/bin/cmvn

CMD ["bash"]
