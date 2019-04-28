FROM node:10.15.3-stretch-slim 

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US:en
ENV VERSION 0.0.238
ENV DOWNLOAD_URL https://github.com/DIYgod/RSSHub/archive/v${VERSION}.tar.gz

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y tzdata locales wget \
    && wget ${DOWNLOAD_URL} -O rsshub.tar.gz \
    && tar -zxvf rsshub.tar.gz \
    && mv RSSHub-${VERSION} /rsshub \
    && (cd /rsshub && npm install --production) \
    && locale-gen --purge en_US.UTF-8 zh_CN.UTF-8 \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && echo 'LANG="en_US.UTF-8"' > /etc/default/locale \
    && echo 'LANGUAGE="en_US:en"' >> /etc/default/locale \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apt purge -y wget \
    && apt autoremove -y \
    && apt autoclean -y \
    && rm -rf /rsshub.tar.gz \
        /src/*.deb \
        /var/lib/apt/lists/*

WORKDIR /rsshub

EXPOSE 1200

CMD ["npm","run","start"]
