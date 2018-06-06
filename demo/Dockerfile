FROM nginx:1.14.0-alpine

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --update \
    && apk add bash tzdata curl wget ca-certificates \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY index.html /usr/share/nginx/html/index.html

COPY docker.png /usr/share/nginx/html/docker.png

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
