FROM centos:7

MAINTAINER mritd <mritd@mritd.me>

RUN yum update -y && \
    yum upgrade -y && \
    yum install -y gcc automake autoconf libtool make gcc-c++ zlib zlib-devel openssl openssl-devel perl perl-devel pcre pcre-devel libxslt libxslt-devel&& \
    yum clean all && \
    rm -rf /usr/local/src/*

ADD nginx-1.10.1.tar.gz /tmp/

RUN cd /tmp/nginx-1.10.1 && \
    ./configure --prefix=/usr/local/nginx \
    --sbin-path=/usr/local/nginx/sbin/nginx \
    --conf-path=/etc/nginx/nginx.conf \
    --user=nginx \
    --group=nginx \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --pid-path=/var/run/nginx/nginx.pid \
    --lock-path=/var/lock/nginx/nginx.lock \
    --http-client-body-temp-path=/tmp/nginx/client \
    --http-proxy-temp-path=/tmp/nginx/http_proxy_temp \
    --http-fastcgi-temp-path=/tmp/nginx/http_fastcgi_temp \
    --http-uwsgi-temp-path=/tmp/nginx/http_uwsgi_temp \
    --http-scgi-temp-path=/tmp/nginx/http_scgi_temp \
    --with-file-aio \
    --with-ipv6 \
    --with-http_ssl_module \
    --with-http_stub_status_module \
    --with-http_gzip_static_module \
    --with-debug && \
    make && make install

RUN useradd -M -s /sbin/nologin nginx && \
    mkdir -p /tmp/nginx/{client,http_proxy_temp,http_fastcgi_temp,http_uwsgi_temp,http_scgi_temp} && \
    mkdir -p /etc/nginx/conf.d && \
    rm -rf /tmp/nginx-1.10.1

ADD conf.d/*.conf /etc/nginx/conf.d/

ADD nginx.conf /etc/nginx/

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
