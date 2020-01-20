FROM nginx:1.17.6-alpine

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV HTTPCMD_TOKEN natural

RUN apk upgrade \
    && apk add bash git tzdata \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /usr/share/nginx/html /var/cache/apk/*

COPY httpcmd /usr/local/bin/httpcmd
COPY endpoint.sh /endpoint.sh

CMD ["/endpoint.sh"]
