FROM alpine:3.4

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --update && \
    apk add --update bash && \
    apk add --update python && \
    apk add --update py-pip && \
    rm -rf /var/cache/apk/*

ADD idea.tar.gz /idea

RUN pip install --upgrade pip

RUN pip install -r /idea/ideaLicenseServer/requirements.txt

CMD ["python","/idea/ideaLicenseServer/jetbrains_license_server/manage.py","runserver","0.0.0.0:80"]
