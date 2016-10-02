FROM nginx:1.11.4-alpine

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

RUN mkdir -p /etc/nginx/ssl && \
    rm -f /etc/nginx/conf.d/default.conf

ADD conf.d/*.conf /etc/nginx/conf.d/

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
