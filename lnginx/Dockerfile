FROM nginx:1.11.4-alpine

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

ADD conf.d/*.conf /etc/nginx/conf.d/

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
