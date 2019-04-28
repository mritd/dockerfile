FROM ubuntu:18.04

MAINTAINER mritd <mritd@linux.com>

ENV TZ 'Asia/Shanghai'
ENV CHROME_VERSION 67.0.3396.79
ENV CHROME_APT "deb https://dl.google.com/linux/chrome/deb/ stable main"

RUN apt update -y && apt upgrade -y \
    && apt install wget tzdata libnss3 libnss3-tools libfontconfig1 \
        gnupg2 ca-certificates apt-transport-https inotify-tools -y \
    && echo ${CHROME_APT} > /etc/apt/sources.list.d/google-chrome.list \
    && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && apt update -y && apt upgrade -y \
    && apt install google-chrome-stable=${CHROME_VERSION}-1 -y \
    && apt autoremove -y && apt autoclean -y \
    && mkdir /data \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

COPY entrypoint.sh /

EXPOSE 9222
VOLUME /data

ENTRYPOINT ["/entrypoint.sh"]
