FROM debian:stretch

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}

ENV NVM_VERSION 0.33.8
ENV NODE_VERSION 8.11.1
ENV OPENJDK_VERSION 8.0.163-zulu
ENV ORACLEJDK_VERSION 8.0.161-oracle

SHELL ["/bin/bash", "-c"]

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install curl wget tar unzip zip tzdata git make gcc g++ libpng-dev -y \
    && wget -qO- https://raw.githubusercontent.com/creationix/nvm/v${NVM_VERSION}/install.sh | bash \
    && curl -s https://get.sdkman.io | bash \
    && source ~/.bashrc \
    && sdk install maven \
    && sdk install gradle \
    && sdk install java ${ORACLEJDK_VERSION} \
    && sdk install java ${OPENJDK_VERSION} \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /tmp/*

COPY sdkconfig /root/.sdkman/etc/config
COPY cnpm /usr/local/bin/cnpm
COPY cmvn /usr/local/bin/cmvn

CMD ["bash"]
