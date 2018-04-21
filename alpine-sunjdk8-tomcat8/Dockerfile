FROM mritd/alpine-oracle-jdk8:8.171.11

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.5.30
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH ${CATALINA_HOME}/bin:${PATH}
ENV TOMCAT_NATIVE_LIBDIR ${CATALINA_HOME}/native-jni-lib
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$TOMCAT_NATIVE_LIBDIR
ENV TOMCAT_TGZ_URL http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz 

RUN apk add --no-cache --virtual .build-deps \
        ca-certificates \
        tar \
        wget \
        openssl \
        openssl-dev \
        apr-dev \
        coreutils \
        dpkg-dev dpkg \
        gcc \
        libc-dev \
        make \
    && mkdir -p ${CATALINA_HOME} \
    && wget -O tomcat.tar.gz ${TOMCAT_TGZ_URL} \
    && tar -xvf tomcat.tar.gz -C ${CATALINA_HOME} --strip-components=1 \
    && nativeBuildDir=$(mktemp -d) \
    && tar -xvf ${CATALINA_HOME}/bin/tomcat-native.tar.gz -C ${nativeBuildDir} --strip-components=1 \
    && ( cd ${nativeBuildDir}/native \
    && gnuArch=$(dpkg-architecture --query DEB_BUILD_GNU_TYPE) \
    && ./configure \
        --build=${gnuArch} \
        --libdir=${TOMCAT_NATIVE_LIBDIR} \
        --prefix=${CATALINA_HOME} \
        --with-apr=$(which apr-1-config) \
        --with-java-home=${JAVA_HOME} \
        --with-ssl=yes \
    && make -j $(nproc) \
    && make install) \
    && runDeps=$( \
        scanelf --needed --nobanner --recursive ${TOMCAT_NATIVE_LIBDIR} \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | sort -u \
            | xargs -r apk info --installed \
            | sort -u \
        ) \
    && apk add --virtual .tomcat-native-rundeps ${runDeps} \
    && nativeLines=$(catalina.sh configtest 2>&1) \
    && nativeLines=$(echo ${nativeLines} | grep 'Apache Tomcat Native') \
    && nativeLines=$(echo ${nativeLines} | sort -u) \
    && if ! echo ${nativeLines} | grep 'INFO: Loaded APR based Apache Tomcat Native library' >&2; then \
           echo >&2 ${nativeLines}; \
           exit 1; \
       fi \
    && apk del .build-deps \
    && rm -rf   ${CATALINA_HOME}/bin/*.bat \
                ${CATALINA_HOME}/bin/tomcat-native.tar.gz \
                ${CATALINA_HOME}/webapps/* \
                tomcat.tar.gz 
    

EXPOSE 8080

CMD ["catalina.sh", "run"] 
