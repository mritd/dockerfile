FROM alpine:3.4

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --update && \
    apk add --update bash libatomic readline readline-dev libxml2 libxml2-dev \
      ncurses-terminfo-base ncurses-terminfo libxslt libxslt-dev zlib-dev zlib \
      ruby ruby-dev yaml yaml-dev libffi-dev build-base git ruby-io-console \
      ruby-irb ruby-json ruby-rake && \
    rm -rf /root/src /tmp/* /usr/share/man /var/cache/apk/*

RUN gem install --no-document redcarpet  maruku rdiscount RedCloth liquid && \
    gem install --no-document sass safe_yaml pygments.rb sass safe_yaml && \
    gem install --no-document jekyll-paginate jekyll-sitemap jekyll-feed && \
    gem install --no-document jekyll-redirect-from bundler github-pages jekyll && \
    gem install --no-document jekyll-sass-converter -v 1.3.0 && \
    gem install --no-document kramdown -v 1.11.1 && \
    gem uninstall jekyll-sass-converter -v 1.4.0 && \
    gem uninstall kramdown -v 1.12.0

RUN git clone https://github.com/mritd/mritd.github.io.git /root/mritd.github.io

WORKDIR /root/mritd.github.io

CMD ["jekyll","serve","-H","0.0.0.0"]
