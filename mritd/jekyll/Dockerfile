FROM ruby:2.3.1-alpine

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --no-cache && \
    apk add --no-cache bash tzdata nodejs py-pygments git && \
    gem install jekyll rdiscount kramdown && \
    git clone https://github.com/mritd/mritd.github.io.git /root/mritd.github.io && \
    cd /root/mritd.github.io && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    rm -rf /var/cache/apk/*

ADD cron/15min/* /etc/periodic/15min

ADD entrypoint.sh /root/entrypoint.sh

WORKDIR /root

CMD ["/root/entrypoint.sh"]
