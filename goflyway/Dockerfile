FROM alpine:3.10

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

RUN apk upgrade --update \
    && apk add bash tzdata \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

ADD goflyway /usr/local/bin/goflyway

ADD chinalist.txt /usr/local/bin/chinalist.txt 

CMD ["goflyway"]
