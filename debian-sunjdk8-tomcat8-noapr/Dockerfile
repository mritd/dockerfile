FROM mritd/debian-sunjdk8:8.191.12

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.5.34
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
ENV TOMCAT_TGZ_URL http://apache.mirrors.ionfish.org/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz

RUN mkdir -p ${CATALINA_HOME} \
    && cd ${CATALINA_HOME} \
    && wget -O tomcat.tar.gz ${TOMCAT_TGZ_URL} \
    && tar -xvf tomcat.tar.gz --strip-components=1 \
    && rm -rf bin/*.bat webapps/* tomcat.tar.gz

EXPOSE 8080

CMD ["catalina.sh", "run"]
