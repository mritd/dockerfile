FROM nginx:1.17.1-alpine

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ='Asia/Shanghai'
ENV TZ ${TZ}

RUN apk upgrade --update \
    && apk add bash tzdata curl wget ca-certificates \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY index.html /usr/share/nginx/html/index.html

COPY docker.png /usr/share/nginx/html/docker.png

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
