FROM openjdk:11.0.2-jre-slim-stretch

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV ACTIVEMQ_VERSION 5.15.8
ENV ACTIVEMQ_MQTT     1883
ENV ACTIVEMQ_AMQP     5672
ENV ACTIVEMQ_UI       8161
ENV ACTIVEMQ_STOMP    61613
ENV ACTIVEMQ_WS       61614
ENV ACTIVEMQ_TCP      61616
ENV ACTIVEMQ_HOME /opt/activemq
ENV ACTIVEMQ apache-activemq-${ACTIVEMQ_VERSION}
ENV ACTIVEMQ_DOWNLOAD_URL https://archive.apache.org/dist/activemq/${ACTIVEMQ_VERSION}/${ACTIVEMQ}-bin.tar.gz
ENV ACTIVEMQ_SHA512_VAL 8c9b3216a0378f6377a9ba35f23915a3a52a1c15ac7b316bc06781d6a6ba83ce775534aa0054bd1aa37fb4d285946f914dbb21a14cc485e180a0d86c834df02e


RUN apt update \
    && apt upgrade -y \
    && apt install bash tzdata curl -y \
    && curl ${ACTIVEMQ_DOWNLOAD_URL} -o ${ACTIVEMQ}-bin.tar.gz \
    && if [ "${ACTIVEMQ_SHA512_VAL}" != "$(sha512sum ${ACTIVEMQ}-bin.tar.gz | awk '{print($1)}')" ]; then \
         echo "sha512 values doesn't match! exiting." && exit 1; \
       fi \
    && tar xzf ${ACTIVEMQ}-bin.tar.gz -C /opt \
    && ln -s /opt/${ACTIVEMQ} ${ACTIVEMQ_HOME} \
    && useradd activemq -U -d ${ACTIVEMQ_HOME} -s /usr/sbin/nologin \
    && chown -R activemq:activemq /opt/${ACTIVEMQ} \
    && chown -h activemq:activemq ${ACTIVEMQ_HOME} \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apt clean

USER activemq

WORKDIR ${ACTIVEMQ_HOME}

EXPOSE ${ACTIVEMQ_TCP}
EXPOSE ${ACTIVEMQ_AMQP}
EXPOSE ${ACTIVEMQ_STOMP}
EXPOSE ${ACTIVEMQ_MQTT}
EXPOSE ${ACTIVEMQ_WS}
EXPOSE ${ACTIVEMQ_UI}

CMD ["/bin/bash", "-c", "bin/activemq console"]
