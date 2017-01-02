FROM alpine:3.5

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

WORKDIR /root

RUN apk upgrade --no-cache \
    && apk add --no-cache \
        bash \
        tzdata \
        curl \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && VERSION="$(curl -s https://api.github.com/repos/v2ray/v2ray-core/releases/latest | grep 'tag_name' | cut -d\" -f4)" \
    && DOWNLOAD_URL="https://github.com/v2ray/v2ray-core/releases/download/${VERSION}/v2ray-linux-64.zip" \
    && mkdir -p \ 
        /var/log/v2ray \
        /usr/bin/v2ray \
        /tmp/v2ray \
        /etc/v2ray/ \
    && curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip ${DOWNLOAD_URL} \
    && unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray/ \
    && cp /tmp/v2ray/v2ray-${VERSION}-linux-64/v2ray /root/v2ray \
    && cp /tmp/v2ray/v2ray-${VERSION}-linux-64/vpoint_vmess_freedom.json /root/config.json \
    && chmod +x /root/v2ray \
    && rm -rf /tmp/v2ray \
    && rm -rf /var/cache/apk/*

ADD entrypoint.sh /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]
