FROM node:10.15.0-alpine

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV VERSION 3.10.2

RUN apk upgrade --update \
    && apk add bash tzdata ca-certificates su-exec python make \
    && npm install --unsafe -g verdaccio@${VERSION} \
    && addgroup -S verdaccio \
    && adduser -S -G verdaccio verdaccio \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del python make \
    && rm -rf /var/cache/apk/*

COPY config.yaml /verdaccio/conf/config.yaml
COPY entrypoint.sh /entrypoint.sh

EXPOSE 4873

VOLUME ["/verdaccio"]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["--config","/verdaccio/conf/config.yaml","--listen","http://0.0.0.0:4873"]
