FROM registry:2.6.0 

LABEL maintainer="mritd <mritd1234@gmail.com>"

ADD config.yml /etc/docker/registry/config.yml

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/*

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/etc/docker/registry/config.yml"]
