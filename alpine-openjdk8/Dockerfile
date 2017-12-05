FROM alpine:3.7

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

RUN apk add --update bash curl tar wget ca-certificates \
                    unzip openjdk8 font-adobe-100dpi \
                    ttf-dejavu fontconfig \
    && rm -rf /var/cache/apk/* \

CMD ["bash"]
