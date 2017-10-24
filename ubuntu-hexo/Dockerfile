FROM ubuntu:16.04
COPY ./sources.list /etc/apt/sources.list
RUN apt-get update \
    &&  apt-get install -y openssh-server openssh-client vim git curl \
    &&  curl -sL https://deb.nodesource.com/setup_8.x |  bash -  \
    &&  apt-get install -y nodejs  \
    &&  npm install npm -g  \
    &&  echo root:geekcloud|chpasswd  \
    &&  sed -i "s/PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config \
    &&  sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config  \
    &&  mkdir /var/run/sshd \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/* 
WORKDIR /Hexo
RUN npm config set user 0 && \
    npm config set unsafe-perm true && \
    npm install hexo-cli -g && \
    hexo init . && \
    npm install hexo-generator-sitemap --save && \
    npm install hexo-generator-feed --save && \
    npm install hexo-deployer-git --save
ENV TZ=Asia/Shanghai
ENV LANG=zh_CN.UTF-8
EXPOSE 22
EXPOSE 4000
CMD ["/usr/sbin/sshd", "-D"]
