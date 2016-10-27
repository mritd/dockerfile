FROM centos:7

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

WORKDIR /root/

VOLUME /data/repo

RUN yum install -y epel-release && yum update -y && \
    yum install -y nginx createrepo crontabs && \
    sed -i 's@/usr/share/nginx/html@/data/repo@gi' /etc/nginx/nginx.conf && \
    echo "*/15  *  *  * *  cd /data/repo/centos/7/ && ls | xargs -i createrepo --update {}" | crontab

ADD entrypoint.sh /root/entrypoint.sh
ADD flush.sh /root/flush.sh

ENTRYPOINT ["/root/entrypoint.sh"]
