FROM python:3.7.0-alpine3.8 AS builder

RUN apk add --update --no-cache \
        g++ gcc libxslt-dev make \
        build-base curl-dev \
    && mkdir -p /var/www/scylla \
    && pip install scylla

CMD ["bash"]

FROM python:3.7.0-alpine3.8

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

RUN apk upgrade --update \
    && apk add bash tzdata curl-dev libxslt-dev \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY --from=builder /usr/local/lib/python3.7/site-packages/ /usr/local/lib/python3.7/site-packages/


WORKDIR /var/www/scylla
VOLUME /var/www/scylla

EXPOSE 8899
EXPOSE 8081

CMD ["python","-m","scylla"]
