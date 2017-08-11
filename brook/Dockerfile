FROM alpine:3.6

LABEL maintainer="mritd <mritd@mritd.me>"

ENV TZ 'Asia/Shanghai'

ENV BROOK_VERSION v20170809

RUN apk upgrade --update \
    && apk add bash tzdata wget \
    && wget --no-check-certificate https://github.com/txthinking/brook/releases/download/${BROOK_VERSION}/brook \
    && chmod +x brook \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/*

ENTRYPOINT ["./brook"]
