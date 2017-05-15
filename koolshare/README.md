```
docker run -h="koolshare-merlin-debian" --name koolshare-merlin-debian -v /home/merlin-docker-home:/home -t -i "debian:latest"
```

```
#================== Dockerfile START ==================
##########################################################
# version : koolshare/koolshare-merlin-debian:20170222v03
##########################################################
# 设置继承自官方镜像
FROM debian:latest
MAINTAINER clang (clangcn@gmail.com)
ENV DEBIAN_FRONTEND noninteractive
RUN rm -rf /var/lib/apt/lists/*
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo "deb http://mirrors.ustc.edu.cn/debian/ jessie main contrib non-free" >/etc/apt/sources.list && \
    echo "deb-src http://mirrors.ustc.edu.cn/debian/ jessie main contrib non-free" >>/etc/apt/sources.list && \
    echo "deb http://mirrors.ustc.edu.cn/debian/ jessie-updates main contrib non-free" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.ustc.edu.cn/debian/ jessie-updates main contrib non-free" >>/etc/apt/sources.list && \
    echo "deb http://mirrors.ustc.edu.cn/debian/ jessie-backports main contrib non-free" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.ustc.edu.cn/debian/ jessie-backports main contrib non-free" >>/etc/apt/sources.list && \
    echo "deb http://mirrors.ustc.edu.cn/debian-security/ jessie/updates main contrib non-free" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.ustc.edu.cn/debian-security/ jessie/updates main contrib non-free" >>/etc/apt/sources.list && \
    rm -rf /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Harbin /etc/localtime && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get --no-install-recommends install -y openssh-server sudo nano net-tools cron e2fsprogs tmux wget vim supervisor openssl curl psmisc git heirloom-mailx autoconf automake bash bison bzip2 diffutils file flex g++ gawk gcc-multilib gettext gperf groff-base libncurses-dev libexpat1-dev libslang2 libssl-dev libtool libxml-parser-perl make patch perl pkg-config python sed shtool tar texinfo unzip zlib1g zlib1g-dev intltool autopoint libltdl7-dev lib32z1-dev lib32stdc++6 automake1.11 libelf-dev:i386 libelf1:i386 && \
    apt-get -y autoremove && \
    mkdir -p /var/run/sshd && \
    sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && \
    echo "UseDNS no" >> /etc/ssh/sshd_config && \
    sed -i 's/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config && \
    sed -i 's/PermitRootLogin .*/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
    echo "alias ls='ls --color=auto'" >> /root/.bashrc && \
    echo "alias ll='ls -lh'" >> /root/.bashrc && \
    echo "alias l='ls -lAh'" >> /root/.bashrc && \
    echo "alias wget='wget --no-check-certificate'" >> /root/.bashrc && \
    echo ". ~/build.sh" >> /root/.bashrc && \
    echo "root:Koolshare123" | chpasswd && \
    mkdir -p /usr/shell/ && \
    wget --no-check-certificate -q https://soft.clang.cn/shell/tmux.sh -O /usr/shell/tmux.sh && \
    wget --no-check-certificate -q https://soft.clang.cn/shell/tmux.conf -O /root/.tmux.conf && \
    chmod +x /usr/shell/tmux.sh && \
    ln -s /usr/shell/tmux.sh /usr/bin/win && \
    mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY build.sh /root/build.sh
RUN chmod +x /root/build.sh
EXPOSE 22
CMD ["/usr/bin/supervisord"]
#================== Dockerfile END ==================
```

```
docker build -t="koolshare/koolshare-merlin-debian:20170222v03" .
```

```
docker login
docker tag koolshare/koolshare-merlin-debian:20170222v03 koolshare/koolshare-merlin-debian:latest
docker push koolshare/koolshare-merlin-debian:latest
```

```
docker run -d -h="koolshare-merlin-debian" \
--name koolshare-merlin-debian \
-v /home/merlin-docker-home/asuswrt-merlin:/home/asuswrt-merlin \
-p 2222:22 \
"koolshare/koolshare-merlin-debian"
```

```
# 导出镜像
docker save "koolshare/koolshare-merlin-debian:latest" >/home/docker-images/koolshare-merlin-debian_20170222v03.tar
# 导入镜像
docker load < /home/docker-images/koolshare-merlin-debian_20170222v03.tar
```

########   build.sh  ########
```
#!/bin/bash
fun_set_text_color(){
    COLOR_RED='\E[1;31m'
    COLOR_GREEN='\E[1;32m'
    COLOR_YELOW='\E[1;33m'
    COLOR_BLUE='\E[1;34m'
    COLOR_PINK='\E[1;35m'
    COLOR_PINKBACK_WHITEFONT='\033[45;37m'
    COLOR_GREEN_LIGHTNING='\033[32m \033[05m'
    COLOR_END='\E[0m'
}
main(){
    echo -e "${COLOR_YELOW}============== Initialized build environment ==============${COLOR_END}"
    if [ -d "/home/asuswrt-merlin/tools/brcm" ] && [ -d "/home/asuswrt-merlin/release/src-rt-6.x.4708/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3" ]; then
        if [ ! -L /opt/brcm-arm ] || [ ! -L /opt/brcm ]; then
            echo -e -n "${COLOR_PINK}link brcm & brcm-arm${COLOR_END}"
            ln -s /home/asuswrt-merlin/tools/brcm /opt/brcm
            ln -s /home/asuswrt-merlin/release/src-rt-6.x.4708/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3 /opt/brcm-arm
            if [ -L /opt/brcm-arm ] && [ -L /opt/brcm ];then
                echo -e " ${COLOR_GREEN}done${COLOR_END}"
            else
                echo -e " ${COLOR_RED}failed${COLOR_END}"
                return 1
            fi
        fi
    else
        echo -e "${COLOR_RED}[error] /home/asuswrt-merlin/ not found${COLOR_END}"
        return 1
    fi
    echo -e -n "${COLOR_PINK}setting Environment...${COLOR_END}"
    CROSS_TOOLCHAINS_DIR=/opt/brcm-arm
    export PATH=$PATH:/opt/brcm/hndtools-mipsel-linux/bin:/opt/brcm/hndtools-mipsel-uclibc/bin:/opt/brcm-arm/bin
    export LD_LIBRARY_PATH=$CROSS_TOOLCHAINS_DIR/lib
    echo -e " ${COLOR_GREEN}done${COLOR_END}"
    #echo "$PATH"
}
fun_set_text_color
main
```

