FROM alpine:3.5

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --update \
    && apk add --no-cache bash \
    && rm -rf /var/cache/apk/*

COPY IntelliJIDEALicenseServer_linux_amd64 /idea 

COPY IntelliJIDEALicenseServer.html /IntelliJIDEALicenseServer.html 

EXPOSE 80

ENTRYPOINT ["/idea","-p","80","-u","mritd"]
