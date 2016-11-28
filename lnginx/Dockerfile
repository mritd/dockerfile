FROM mritd/nginx-ext

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

ADD conf.d/test.conf /etc/nginx/conf.d/default.conf

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
