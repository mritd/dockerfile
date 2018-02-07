FROM perl:5.26

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y unzip tzdata \
    && cpanm Encode::Locale IO::Socket::SSL Mojolicious \
    && wget -q https://github.com/sjdy521/Mojo-Webqq/archive/master.zip -O Mojo-Webqq.zip \
    && unzip -qo Mojo-Webqq.zip \
    && (cd Mojo-Webqq-master \
    && cpanm .) \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf Mojo-Webqq-master Mojo-Webqq.zip

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
