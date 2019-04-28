FROM alpine:3.8

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"
ARG GSNOVA_VER="latest"

ENV TZ ${TZ}
ENV GSNOVA_VER ${GSNOVA_VER}
ENV GSNOVA_DOWNLOAD_URL https://github.com/yinqiwen/gsnova/releases/download/${GSNOVA_VER}/gsnova_linux_amd64-${GSNOVA_VER}.tar.bz2

RUN apk upgrade --update \
    && apk add curl tzdata \
    && mkdir gsnova \
    && (cd gsnova && curl -sfSL ${GSNOVA_DOWNLOAD_URL} | tar xj) \
    && mv /gsnova/gsnova /usr/bin/gsnova \
    && mv /gsnova /etc/gsnova \
    && chmod +x /usr/bin/gsnova \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del curl \
    && rm -rf /var/cache/apk/*

# Document that the service listens on port 9443.
EXPOSE 9443 9444 9445 9446

# Run the outyet command by default when the container starts.
CMD ["gsnova","-cmd" ,"-server", "-key", "809240d3a021449f6e67aa73221d42df942a308a", "-listen", "tcp://:9443", "-listen", "quic://:9443", "-listen", "http://:9444", "-listen", "kcp://:9444", "-listen", "http2://:9445", "-listen", "tls://:9446", "-log", "console"]
