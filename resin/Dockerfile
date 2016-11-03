FROM alpine:3.4

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai' \
    JAVA_VERSION=8 \
    JAVA_UPDATE=112 \
    JAVA_BUILD=15 \
    JAVA_HOME="/usr/local/jdk-${JAVA_VERSION}u${JAVA_UPDATE}" \
    RESIN_VERSION 4.0.49

RUN apk upgrade --update && \
    apk add --no-cache bash tzdata wget \
            gcc libc-dev make openssl-dev pcre-dev inux-headers \
            libxslt-dev gd-dev geoip-dev perl-dev && \
    wget http://www.caucho.com/download/resin-$RESIN_VERSION.tar.gz && \
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz && \
    tar -zxvf resin-$RESIN_VERSION.tar.gz && \
    tar -xzf "jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
    mv "jdk-${JAVA_VERSION}u${JAVA_UPDATE}" /usr/local && \
    ln -s "$JAVA_HOME/bin/"* "/usr/bin/" && \
    (cd resin-$RESIN_VERSION && \
    ./configure --prefix=/usr/local/resin-$RESIN_VERSION \
                --with-java-home=/usr/local/jdk1.8.0_111 \
                --enable-64bit && \
    make && make install) && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    rm -rf "$JAVA_HOME/"*src.zip && \
    rm -rf "$JAVA_HOME/lib/missioncontrol" \
           "$JAVA_HOME/lib/visualvm" \
           "$JAVA_HOME/lib/"*javafx* \
           "$JAVA_HOME/jre/lib/plugin.jar" \
           "$JAVA_HOME/jre/lib/ext/jfxrt.jar" \
           "$JAVA_HOME/jre/bin/javaws" \
           "$JAVA_HOME/jre/lib/javaws.jar" \
           "$JAVA_HOME/jre/lib/desktop" \
           "$JAVA_HOME/jre/plugin" \
           "$JAVA_HOME/jre/lib/"deploy* \
           "$JAVA_HOME/jre/lib/"*javafx* \
           "$JAVA_HOME/jre/lib/"*jfx* \
           "$JAVA_HOME/jre/lib/amd64/libdecora_sse.so" \
           "$JAVA_HOME/jre/lib/amd64/"libprism_*.so \
           "$JAVA_HOME/jre/lib/amd64/libfxplugins.so" \
           "$JAVA_HOME/jre/lib/amd64/libglass.so" \
           "$JAVA_HOME/jre/lib/amd64/libgstreamer-lite.so" \
           "$JAVA_HOME/jre/lib/amd64/"libjavafx*.so \
           "$JAVA_HOME/jre/lib/amd64/"libjfx*.so && \
    rm -f resin-$RESIN_VERSION.tar.gz \
          "jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
    rm -rf /var/cache/apk/*

CMD ["/bin/bash"]
