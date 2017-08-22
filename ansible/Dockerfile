FROM alpine:3.5

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --update \
    && apk add bash tzdata sudo python py-pip \
                openssl ca-certificates sshpass \
                openssh-client rsync\
    && apk add --virtual build-dependencies python-dev \
                libffi-dev openssl-dev build-base \
    && pip install --upgrade pip cffi ansible \
    && mkdir -p /etc/ansible \
    && echo 'localhost' > /etc/ansible/hosts \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del build-dependencies \
    && rm -rf /var/cache/apk/*

CMD ["/bin/bash"]
