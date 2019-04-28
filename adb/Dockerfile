FROM frolvlad/alpine-glibc:alpine-3.9_glibc-2.29

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV PATH ${PATH}:/opt/platform-tools

COPY update-platform-tools.sh /update-platform-tools.sh
COPY adbkey* /root/.android/

RUN apk upgrade --update \
    && apk add bash tzdata wget ca-certificates xmlstarlet \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && /update-platform-tools.sh \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

EXPOSE 5037

CMD ["adb", "-a", "-P", "5037", "server", "nodaemon"] 
