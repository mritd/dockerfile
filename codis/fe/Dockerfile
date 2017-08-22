FROM frolvlad/alpine-glibc 

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TZ 'Asia/Shanghai'
ENV CODIS_VERSION 3.1.5
ENV GOLANG_VERSION 1.7.5
ENV CODIS_MODULE codis-fe
ENV CODIS_FILENAME codis${CODIS_VERSION}-go${GOLANG_VERSION}-linux.tar.gz 
ENV CODIS_URL https://github.com/CodisLabs/codis/releases/download/${CODIS_VERSION}/${CODIS_FILENAME}

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata wget \
    && wget --no-check-certificate ${CODIS_URL} \ 
    && tar -zxf ${CODIS_FILENAME} \
    && mv codis${CODIS_VERSION}-go${GOLANG_VERSION}-linux/${CODIS_MODULE} / \
    && mv codis${CODIS_VERSION}-go${GOLANG_VERSION}-linux/assets / \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf codis${CODIS_VERSION}-go${GOLANG_VERSION}-linux \
    && rm -f ${CODIS_FILENAME} \
    && rm -rf /var/cache/apk/*

ADD codis-fe.json /etc/codis-fe.json

CMD ["/bin/bash"]
