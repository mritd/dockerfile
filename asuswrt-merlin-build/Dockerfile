FROM ubuntu:16.04 

MAINTAINER mritd <mritd1234@gmail.com> 

COPY build.sh /root/build.sh

RUN dpkg --add-architecture i386 \
    && apt-get update -y \
    && apt-get install -y \
        sudo net-tools cron e2fsprogs wget vim openssl curl psmisc git \
        heirloom-mailx autoconf automake bison bzip2 diffutils \
        sed file flex g++ gawk gcc-multilib gettext gperf groff-base \
        libncurses-dev libexpat1-dev libslang2 libssl-dev libtool \
        libxml-parser-perl make patch perl pkg-config python shtool tar \
        texinfo unzip zlib1g zlib1g-dev intltool autopoint libltdl7-dev \
        lib32z1-dev lib32stdc++6 automake1.11 libelf-dev:i386 libelf1:i386 \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" \
    && echo ". ~/build.sh" >> /root/.zshrc 

CMD ["zsh"]
