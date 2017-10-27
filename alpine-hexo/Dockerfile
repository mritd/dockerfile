FROM node:8.7-alpine

LABEL maintainer="Linus Lee <708863861@qq.com>"

# set TimeZone
ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

# copy git config 
COPY git.config /git.config

# install git bash tzdata
RUN apk --update --no-progress add git bash tzdata \
    # set npm to install hexo
    && npm config set user 0 \
    && npm config set unsafe-perm true \
    # install hexo 
    && npm install hexo-cli -g \
    && hexo init Hexo \
    # init hexo & config generator
    && (cd Hexo \
    && npm install \
    && npm install hexo-deployer-git --save \
    && mv /git.config _config.yml) \
    # add link & clean 
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

# use TCP port 4000 to run hexo server 
EXPOSE 4000

CMD ["/bin/bash"]
