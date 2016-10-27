FROM centos:7

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

VOLUME /usr/share/nginx/html/

RUN yum install -y createrepo epel-release nginx && \
    mkdir -p /usr/share/nginx/html/centos/7.2/{i386,x86_64,noarch,updates,SRPMS} && \
    cd /usr/share/nginx/html/centos/7.2/ && ls | xargs -i createrepo {} && \
    echo "*/15  *  *  * *  cd /usr/share/nginx/html/centos/7.2/ && ls | xargs -i createrepo --update {}" | crontab

ADD entrypoint.sh /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]
