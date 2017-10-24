FROM alpine:3.6

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ

RUN apk upgrade --update && \
    && apk add bash dnsmasq \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

ADD config/* /etc/

EXPOSE 53 53/udp

ENTRYPOINT ["dnsmasq", "-k"]
