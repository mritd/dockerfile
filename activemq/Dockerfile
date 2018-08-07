FROM openjdk:8u171-jre-alpine3.8

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV ACTIVEMQ_VERSION 5.15.4
ENV ACTIVEMQ_MQTT     1883
ENV ACTIVEMQ_AMQP     5672
ENV ACTIVEMQ_UI       8161
ENV ACTIVEMQ_STOMP    61613
ENV ACTIVEMQ_WS       61614
ENV ACTIVEMQ_TCP      61616
ENV ACTIVEMQ_HOME /opt/activemq
ENV ACTIVEMQ apache-activemq-${ACTIVEMQ_VERSION}
ENV ACTIVEMQ_DOWNLOAD_URL https://archive.apache.org/dist/activemq/${ACTIVEMQ_VERSION}/${ACTIVEMQ}-bin.tar.gz
ENV ACTIVEMQ_SHA512_VAL 26d8154fcfe17ab90508b3b9d46b40815404fa3886cfdc4eae4b06086332203bd2455475b9309ccabd76d0c9b65f523f9d3911d315c17bf4b48bd22395ea8ead


RUN apk upgrade \
    && apk add bash tzdata curl \
    && curl ${ACTIVEMQ_DOWNLOAD_URL} -o ${ACTIVEMQ}-bin.tar.gz \
    && if [ "${ACTIVEMQ_SHA512_VAL}" != "$(sha512sum ${ACTIVEMQ}-bin.tar.gz | awk '{print($1)}')" ]; then \
         echo "sha512 values doesn't match! exiting." && exit 1; \
       fi \
    && mkdir /opt \
    && tar xzf ${ACTIVEMQ}-bin.tar.gz -C /opt \
    && ln -s /opt/${ACTIVEMQ} ${ACTIVEMQ_HOME} \
    && addgroup -S activemq \
    && adduser -S -H -G activemq -h ${ACTIVEMQ_HOME} activemq \
    && chown -R activemq:activemq /opt/${ACTIVEMQ} \
    && chown -h activemq:activemq ${ACTIVEMQ_HOME} \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del curl \
    && rm -rf /var/cache/apk/*

USER activemq

WORKDIR ${ACTIVEMQ_HOME}

EXPOSE ${ACTIVEMQ_TCP}
EXPOSE ${ACTIVEMQ_AMQP}
EXPOSE ${ACTIVEMQ_STOMP}
EXPOSE ${ACTIVEMQ_MQTT}
EXPOSE ${ACTIVEMQ_WS}
EXPOSE ${ACTIVEMQ_UI}

CMD ["/bin/sh", "-c", "bin/activemq console"]
