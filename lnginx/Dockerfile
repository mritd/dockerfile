FROM mritd/nginx-ext

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

ADD conf.d/*.conf /etc/nginx/conf.d/

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
