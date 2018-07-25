FROM ubuntu:18.04

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV PRITUNL_VERSION 1.29.1765.91
ENV PRITUNL_NDPPD_VERSION 0.2.5
ENV PRITUNL_DOWNLOAD_URL http://repo.pritunl.com/stable/apt/pool/main/p/pritunl/pritunl_${PRITUNL_VERSION}-0ubuntu1~bionic_amd64.deb
ENV PRITUNL_NDPPD_DOWNLOAD_URL http://repo.pritunl.com/stable/apt/pool/main/p/pritunl-ndppd/pritunl-ndppd_${PRITUNL_NDPPD_VERSION}-0ubuntu1~bionic_amd64.deb 

RUN apt update -y \
    && apt upgrade -y \
    && apt install wget unzip tzdata locales python openvpn bridge-utils net-tools psmisc iptables -y \
    && wget ${PRITUNL_DOWNLOAD_URL} -O pritunl.deb \
    && wget ${PRITUNL_NDPPD_DOWNLOAD_URL} -O pritunl_ndppd.deb \
    && dpkg -i pritunl.deb pritunl_ndppd.deb \
    && locale-gen --purge en_US.UTF-8 zh_CN.UTF-8 \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && echo -e 'LANG="en_US.UTF-8"' > /etc/default/locale \
    && echo -e 'LANGUAGE="en_US:en"' >> /etc/default/locale \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && apt autoremove \
    && apt autoclean \
    && rm -rf /etc/pritunl.conf *.deb /tmp/*

VOLUME /etc/pritunl.conf

EXPOSE 80 443
EXPOSE 1194 1194/udp

CMD ["pritunl","start"]
