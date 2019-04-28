FROM centos:7

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}

RUN yum install -y epel-release \
    && yum update -y \
    && yum install -y nginx createrepo crontabs \
    && sed -i 's@/usr/share/nginx/html@/data/repo@gi' /etc/nginx/nginx.conf \
    && echo "*/15  *  *  * *  cd /data/repo/centos/7/ && ls | xargs -i createrepo --update {}" | crontab

ADD entrypoint.sh /entrypoint.sh
ADD flush.sh /flush.sh

VOLUME /data/repo

ENTRYPOINT ["/entrypoint.sh"]
