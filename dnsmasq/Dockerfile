FROM alpine:3.6

LABEL maintainer="mritd <mritd1234@gmail.com>"

RUN apk upgrade --update && \
    && apk add --no-cache bash dnsmasq \
    && rm -rf /var/cache/apk/*

ADD config/* /etc/

EXPOSE 53 53/udp

ENTRYPOINT ["dnsmasq", "-k"]
