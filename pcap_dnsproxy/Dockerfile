FROM alpine:3.7

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV VERSION 0.4.9.8
ENV CONFIG_PATH /etc/pcapdns
ENV DOWNLOAD_URL https://github.com/chengr28/Pcap_DNSProxy/archive/v${VERSION}.tar.gz

RUN apk upgrade --update \
    && apk add bash tzdata \
    && apk add --virtual .build-deps \
        gcc \
        g++ \
        make \
        cmake \
        libevent-dev \
        libpcap-dev \
        libsodium-dev \
        openssl-dev \
        wget \
    && wget ${DOWNLOAD_URL} \
    && tar -zxvf v${VERSION}.tar.gz \
    && sed -i "22a#define    fcloseall() (void)0" \
        Pcap_DNSProxy-${VERSION}/Source/Pcap_DNSProxy/Platform.h \
    && (cd Pcap_DNSProxy-${VERSION}/Source/Auxiliary/Scripts \
    && bash CMake_Build.sh) \
    && mkdir ${CONFIG_PATH} \
    && mv Pcap_DNSProxy-${VERSION}/Source/Release/Pcap_DNSProxy /usr/bin \
    && mv Pcap_DNSProxy-${VERSION}/Source/Release/*.conf ${CONFIG_PATH} \
	&& runDeps="$( \
        scanelf --needed --nobanner /usr/bin/Pcap_DNSProxy \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | xargs -r apk info --installed \
            | sort -u \
        )" \
	&& apk add --virtual .run-deps ${runDeps} \
	&& apk del .build-deps \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf v${VERSION}.tar.gz \
        Pcap_DNSProxy-${VERSION} \
        /var/cache/apk/*

CMD ["Pcap_DNSProxy","-c","/etc/pcapdns","--disable-daemon"]
