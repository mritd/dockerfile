FROM alpine:3.10

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV METRICBEAT_VERSION 6.4.0
ENV METRICBEAT_HOME /usr/share/metricbeat
ENV METRICBEAT_DOWNLOAD_URL https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-${METRICBEAT_VERSION}-linux-x86_64.tar.gz 

RUN apk upgrade \
    && apk add bash tzdata libc6-compat \
    && apk add --virtual=build-dependencies wget ca-certificates \
    && wget -q ${METRICBEAT_DOWNLOAD_URL} \
    && mkdir -p ${METRICBEAT_HOME}/data ${METRICBEAT_HOME}/logs \
    && tar -zxf metricbeat-${METRICBEAT_VERSION}-linux-x86_64.tar.gz \
        -C ${METRICBEAT_HOME} --strip-components 1 \
    && rm -f metricbeat-${METRICBEAT_VERSION}-linux-x86_64.tar.gz \
        ${METRICBEAT_HOME}/.build_hash.txt \
        ${METRICBEAT_HOME}/NOTICE \
        ${METRICBEAT_HOME}/README.md \
    && ln -s ${METRICBEAT_HOME}/metricbeat /usr/bin/metricbeat \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del build-dependencies \
    && rm -rf /var/cache/apk/*

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME /etc/metricbeat

ENTRYPOINT ["/entrypoint.sh"]

CMD ["-e","-c","/etc/metricbeat.yaml"]
