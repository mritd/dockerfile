FROM debian:stretch AS builder

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV MTPROXY_DOWNLOAD_URL https://github.com/TelegramMessenger/MTProxy.git

RUN apt update -y && apt upgrade -y \
    && apt install git curl build-essential libssl-dev zlib1g-dev -y \
    && git clone ${MTPROXY_DOWNLOAD_URL} MTProxy \
    && cd MTProxy && make

FROM debian:stretch

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TZ 'Asia/Shanghai'
ENV MTPROXY_CONFIG_PATH /etc/mtproxy
ENV MTPROXY_CONFIG_DOWNLOAD_URL https://core.telegram.org/getProxyConfig
ENV MTPROXY_SECRET_DOWNLOAD_URL https://core.telegram.org/getProxySecret

RUN apt update -y && apt upgrade -y \
    && apt install openssl xxd curl -y \
    && mkdir ${MTPROXY_CONFIG_PATH} \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

COPY --from=builder /MTProxy/objs/bin/mtproto-proxy /usr/bin/mtproto-proxy
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
