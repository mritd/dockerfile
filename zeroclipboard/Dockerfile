FROM alpine:3.6

LABEL maintainer="mritd <mritd@linux.com>"

COPY Gemfile Gemfile

RUN apk upgrade --update \
    && apk add bash build-base libffi zlib libxml2 \
        libxslt ruby ruby-io-console ruby-json yaml \
        nodejs git perl tzdata \
    && apk add --no-cache --virtual .build-deps \
        build-base libffi-dev zlib-dev libxml2-dev \
        libxslt-dev ruby-dev \
    && git clone -b gh-pages https://github.com/zeroclipboard/zeroclipboard.org.git /root/zeroclipboard.org \
    && echo 'gem: --no-document' >> ~/.gemrc \
    && cp ~/.gemrc /etc/gemrc \
    && chmod uog+r /etc/gemrc \
    && echo "gem 'ffi','1.9.18'" >> /root/zeroclipboard.org/Gemfile \
    && echo "gem 'posix-spawn','0.3.13'" >> /root/zeroclipboard.org/Gemfile \
    && gem install bundler \
    && bundle config build.jekyll --no-rdoc \
    && bundle install \
    && cd /root/zeroclipboard.org \
    && rm -f Gemfile.lock \
    && bundle install \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del .build-deps \
    && rm -f /Gemfile* \
    && rm -rf /var/cache/apk/* \
    && rm -rf /usr/lib/lib/ruby/gems/*/cache/* \
    && rm -rf ~/.gem

WORKDIR /root/zeroclipboard.org

CMD ["jekyll","serve","-H","0.0.0.0"]
