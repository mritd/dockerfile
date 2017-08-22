FROM alpine:3.6

LABEL maintainer="mritd <mritd1234@gmail.com>"

COPY Gemfile Gemfile

RUN apk upgrade --update \
    && apk add bash build-base libffi zlib libxml2 \
        libxslt ruby ruby-io-console ruby-json yaml \
        nodejs git perl tzdata \
    && apk add --no-cache --virtual .build-deps \
        build-base libffi-dev zlib-dev libxml2-dev \
        libxslt-dev ruby-dev \
    && echo 'gem: --no-document' >> ~/.gemrc \
    && cp ~/.gemrc /etc/gemrc \
    && chmod uog+r /etc/gemrc \
    && gem install bundler \
    && bundle config build.jekyll --no-rdoc \
    && bundle install \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del .build-deps \
    && rm -f /Gemfile* \
    && rm -rf /var/cache/apk/* \
    && rm -rf /usr/lib/lib/ruby/gems/*/cache/* \
    && rm -rf ~/.gem

WORKDIR /root

CMD ["/bin/bash"]
