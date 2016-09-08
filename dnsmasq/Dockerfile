FROM alpine:3.4

MAINTAINER mritd <mritd@mritd.me>

RUN apk upgrade --update && \
    apk add --update bash && \
    apk add --update dnsmasq && \
    rm -rf /var/cache/apk/*

ADD config/* /etc/


CMD ["/bin/bash"]
