FROM centos:7

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

WORKDIR /root/

VOLUME /usr/share/nginx/html/

RUN yum install -y epel-release && yum update -y && \
    yum install -y nginx createrepo crontabs && \
    echo "*/15  *  *  * *  cd /usr/share/nginx/html/centos/7/ && ls | xargs -i createrepo --update {}" | crontab

ADD entrypoint.sh /root/entrypoint.sh
ADD flush.sh /root/flush.sh

ENTRYPOINT ["/root/entrypoint.sh"]
