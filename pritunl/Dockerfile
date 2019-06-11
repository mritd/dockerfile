FROM ubuntu:18.04

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV APT_REPO "deb http://repo.pritunl.com/stable/apt bionic main"
ENV GPG_KEY 7568D9BB55FF9E5287D586017AE645C0CF8E292A

RUN apt update -y \
    && apt install gnupg -y \
    && echo ${APT_REPO}  >> /etc/apt/sources.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv ${GPG_KEY} \
    && apt update -y \
    && apt upgrade -y \
    && apt install tzdata locales bridge-utils net-tools python pritunl psmisc iptables -y \
    && locale-gen --purge en_US.UTF-8 zh_CN.UTF-8 \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && echo -e 'LANG="en_US.UTF-8"' > /etc/default/locale \
    && echo -e 'LANGUAGE="en_US:en"' >> /etc/default/locale \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && apt autoremove \
    && apt autoclean \
    && rm -rf /tmp/*

EXPOSE 80 443
EXPOSE 1194 1194/udp

CMD ["pritunl","start"]
