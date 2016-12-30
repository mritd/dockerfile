FROM nginx:1.11.8-alpine 

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY index.html /usr/share/nginx/html/index.html

COPY docker.png /usr/share/nginx/html/docker.png

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
