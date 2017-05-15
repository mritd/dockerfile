FROM ubuntu:16.04 

MAINTAINER mritd <mritd@mritd.me> 

ENV ASUSWRT_MERLIN_VERSION 380.66

# add apt-get mirror
COPY sources.list /etc/apt/sources.list 

# add build shell
COPY build.sh /root/build.sh

RUN dpkg --add-architecture i386 \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        openssh-server sudo nano net-tools cron e2fsprogs \
        wget vim openssl curl psmisc git heirloom-mailx autoconf \
        automake bison bzip2 diffutils file flex g++ gawk \
        gcc-multilib gettext gperf groff-base libncurses-dev \
        libexpat1-dev libslang2 libssl-dev libtool libxml-parser-perl \
        make patch perl pkg-config python sed shtool tar texinfo unzip \
        zlib1g zlib1g-dev intltool autopoint libltdl7-dev lib32z1-dev \
        lib32stdc++6 automake1.11 libelf-dev:i386 libelf1:i386 \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && wget https://github.com/RMerl/asuswrt-merlin/archive/${ASUSWRT_MERLIN_VERSION}.tar.gz \
    && tar -zxvf ${ASUSWRT_MERLIN_VERSION}.tar.gz \
    && mv asuswrt-merlin-${ASUSWRT_MERLIN_VERSION} /home/asuswrt-merlin \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" \
    && echo ". ~/build.sh" >> /root/.zshrc 

CMD ["zsh"]
