FROM node:9.9.0-alpine

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV ELASTIC_CONTAINER true
ENV KIBANA_VERSION 6.2.3
ENV KIBANA_HOME /usr/local/kibana
ENV KIBANA_DOWNLOAD_URL https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz
ENV XPACK_DOWNLOAD_URL https://artifacts.elastic.co/downloads/packs/x-pack/x-pack-${KIBANA_VERSION}.zip

RUN apk upgrade --update \
    && apk add bash tzdata fontconfig freetype tar curl \
    && mkdir ${KIBANA_HOME} \
    && (cd ${KIBANA_HOME} \
    && curl -Ls ${KIBANA_DOWNLOAD_URL} | tar --strip-components=1 -zxf - \
    && ln -s ${KIBANA_HOME}/bin/* /usr/local/bin) \
    && sed -i 's@^NODE=.*@@gi' ${KIBANA_HOME}/bin/kibana-plugin \
    && sed -i 's@^test\ -x.*@NODE=$(which node)@gi' ${KIBANA_HOME}/bin/kibana-plugin \
    && kibana-plugin install ${XPACK_DOWNLOAD_URL} \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY config/* ${KIBANA_HOME}/config/
COPY kibana-docker /usr/local/bin/kibana-docker 

CMD ["kibana-docker"]
