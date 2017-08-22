FROM ruby:2.3.1-alpine

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata \
    && apk add --no-cache --virtual .build-deps gcc make musl-dev \
    && gem install fluentd --no-ri --no-rdoc \
    && gem install -V fluentd-ui \
    && apk del .build-deps \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/*

EXPOSE 9292 24224 24230

CMD ["fluentd-ui", "start"]
