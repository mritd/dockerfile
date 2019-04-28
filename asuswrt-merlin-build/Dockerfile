FROM ubuntu:16.04 

LABEL maintainer="mritd <mritd@linux.com>"

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Asuswrt Merlin Build" \
      org.label-schema.description="Asuswrt Merlin 固件交叉编译环境" \
      org.label-schema.url="https://mritd.me" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/mritd/dockerfile/tree/master/asuswrt-merlin-build" \
      org.label-schema.vendor="mritd" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

ENV ASUSWRT_MERLIN_VERSION 380.66

COPY build.sh /root/build.sh

COPY download_merlin.sh /root/download_merlin.sh 

RUN dpkg --add-architecture i386 \
    && apt-get update -y \
    && apt-get install -y \
        sudo net-tools cron e2fsprogs wget vim openssl curl psmisc git \
        heirloom-mailx autoconf automake bison bzip2 bsdtar diffutils \
        sed file flex g++ gawk gcc-multilib gettext gperf groff-base \
        zsh libncurses-dev libexpat1-dev libslang2 libssl-dev libtool \
        libxml-parser-perl make patch perl pkg-config python shtool tar \
        texinfo unzip zlib1g zlib1g-dev intltool autopoint libltdl7-dev \
        lib32z1-dev lib32stdc++6 automake1.11 libelf-dev:i386 libelf1:i386 \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && chsh -s /bin/zsh \
    && echo ". ~/build.sh" >> /root/.zshrc 

CMD ["zsh"]
