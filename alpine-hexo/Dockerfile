FROM node:8.7-alpine
# Change image
LABEL maintainer="mritd <mritd1234@gmail.com>"
# set TimeZone
ARG TZ="Asia/Shanghai"
ENV TZ ${TZ}
# install git bash tzdata
RUN apk --update --no-progress add git bash tzdata  && \
# set npm to install hexp
    npm config set user 0 && \
    npm config set unsafe-perm true && \
# install hexo 
    npm install hexo-cli -g && \
    hexo init Hexo  && \
# init hexo & config generator
    (cd Hexo && \
    npm install hexo-generator-sitemap --save && \
    npm install hexo-generator-feed --save && \
    npm install hexo-deployer-git --save)\
# add link & clean 
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*
# use TCP port 4000 to run hexo server 
EXPOSE 4000
CMD ["/bin/bash"]
