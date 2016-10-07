FROM alpine:3.4

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --update && \
    apk add --update bash libatomic readline readline-dev libxml2 libxml2-dev \
      ncurses-terminfo-base ncurses-terminfo libxslt libxslt-dev zlib-dev zlib \
      ruby ruby-dev yaml yaml-dev libffi-dev build-base git ruby-io-console \
      ruby-irb ruby-json ruby-rake tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    rm -rf /root/src /tmp/* /usr/share/man /var/cache/apk/*

RUN git clone https://github.com/mritd/mritd.github.io.git /root/mritd.github.io && \
    cd /root/mritd.github.io && \
    gem install --no-document bundle && \
    bundle install

ADD cron/15min/* /etc/periodic/15min

ADD entrypoint.sh /root/entrypoint.sh

WORKDIR /root

CMD ["./entrypoint.sh"]
