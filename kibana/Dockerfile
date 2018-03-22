FROM alpine:3.7

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV ELASTIC_CONTAINER true
ENV KIBANA_VERSION 6.2.3
ENV KIBANA_HOME /usr/local/kibana
ENV KIBANA_DOWNLOAD_URL https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz
ENV X-PACK_DOWNLOAD_URL https://artifacts.elastic.co/downloads/packs/x-pack/x-pack-${KIBANA_VERSION}.zip

RUN set -ex && apk upgrade --update \
    && apk add bash tzdata fontconfig freetype tar curl \
    && mkdir ${KIBANA_HOME} \
    && (cd ${KIBANA_HOME} \
    && curl -Ls ${KIBANA_DOWNLOAD_URL} | tar --strip-components=1 -zxf - \
    && ln -s ${KIBANA_HOME} /opt/kibana \
    && ln -s ${KIBANA_HOME}/bin/* /usr/local/bin) \
    && kibana-plugin install ${X-PACK_DOWNLOAD_URL} \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY config/* ${KIBANA_HOME}/config/
COPY kibana-docker /usr/local/bin/kibana-docker 

CMD ["kibana-docker"]
