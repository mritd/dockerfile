FROM python:3.6.10-alpine3.11

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV VERSION v0.2.4
ENV SOURCE_DIR /usr/local/elastalert
ENV CONFIG_DIR /etc/elastalert
ENV DOWNLOAD_URL https://github.com/Yelp/elastalert/archive/${VERSION}.tar.gz

RUN set -ex \
    && apk upgrade \
    && apk add bash wget curl ca-certificates tzdata openssl libmagic \
    && apk add --virtual .build-deps tar openssl-dev libffi-dev gcc musl-dev \
    && mkdir -p ${SOURCE_DIR} ${CONFIG_DIR} \
    && wget ${DOWNLOAD_URL} -O elastalert.tar.gz \
    && tar -zxf elastalert.tar.gz -C ${SOURCE_DIR} --strip-components 1 \
    && (cd ${SOURCE_DIR} \
    && pip install -r requirements.txt \
    && python setup.py install) \
    && cp ${SOURCE_DIR}/config.yaml.example ${CONFIG_DIR}/config.yaml \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del .build-deps \
    && rm -rf ~/.cache elastalert.tar.gz ${SOURCE_DIR} /var/cache/apk/*

ENTRYPOINT ["elastalert"]

CMD ["--verbose","--config","/etc/elastalert/config.yaml"]
