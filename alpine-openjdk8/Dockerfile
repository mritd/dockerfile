FROM alpine:edge 

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin
ENV JAVA_VERSION 8u144
ENV JAVA_ALPINE_VERSION 8.144.01-r0

RUN apk add --update bash curl tar wget ca-certificates unzip \
        openjdk8=${JAVA_ALPINE_VERSION} font-adobe-100dpi ttf-dejavu fontconfig \
    && rm -rf /var/cache/apk/* \

CMD ["bash"]
