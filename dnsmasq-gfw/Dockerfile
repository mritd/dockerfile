FROM alpine:3.5

MAINTAINER mritd <mritd@mritd.me>

RUN apk upgrade --update \
    && apk add --no-cache bash dnsmasq git \
    && git clone https://github.com/racaljk/hosts.git /root/hosts \
    && rm -rf /var/cache/apk/*

ADD config/* /etc/

ADD cron/15min/* /etc/periodic/15min

ADD entrypoint.sh /entrypoint.sh

WORKDIR /root

EXPOSE 53 53/udp

ENTRYPOINT ["/entrypoint.sh"]
