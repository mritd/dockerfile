FROM alpine:3.6

LABEL maintainer="mritd <mritd@mritd.me>"

ENV TZ 'Asia/Shanghai'

ENV BROOK_VERSION v20170809

RUN apk upgrade --update \
    && apk add bash tzdata wget \
    && wget --no-check-certificate https://github.com/txthinking/brook/releases/download/${BROOK_VERSION}/brook \
        -O /usr/local/bin/brook \
    && chmod +x /usr/local/bin/brook \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/*

CMD ["brook"]
