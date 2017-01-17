FROM openjdk:8u111-jre-alpine 

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'
ENV SONATYPE_DIR /usr/local/sonatype
ENV SONATYPE_WORK ${SONATYPE_DIR}/sonatype-work
ENV NEXUS_VERSION 3.2.0-01
ENV NEXUS_HOME ${SONATYPE_DIR}/nexus
ENV NEXUS_DATA /data/nexus-data
ENV NEXUS_CONTEXT ''
ENV JAVA_MAX_MEM 1200m 
ENV JAVA_MIN_MEM 1200m
ENV EXTRA_JAVA_OPTS ""

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata wget tar \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && mkdir -p ${SONATYPE_DIR} ${SONATYPE_WORK} ${NEXUS_DATA} \
    && wget --no-check-certificate https://download.sonatype.com/nexus/3/nexus-${NEXUS_VERSION}-unix.tar.gz \
    && tar -zxvf nexus-${NEXUS_VERSION}-unix.tar.gz \
    && mv nexus-${NEXUS_VERSION} ${NEXUS_HOME} \
    && sed -e '/^nexus-context/ s:$:${NEXUS_CONTEXT}:' -i ${NEXUS_HOME}/etc/nexus-default.properties \
    && addgroup -S nexus \
    && adduser -S -h ${NEXUS_DATA} -s /bin/false -G nexus nexus \
    && ln -s ${NEXUS_DATA} ${SONATYPE_WORK}/nexus3 \
    && chown -R nexus:nexus ${SONATYPE_DIR} \
    && rm -rf /var/cache/apk/*

USER nexus

WORKDIR ${NEXUS_HOME}

VOLUME ${NEXUS_DATA}

EXPOSE 8081

CMD ["bin/nexus", "run"]
