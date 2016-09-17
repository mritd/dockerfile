FROM alpine:3.4

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

WORKDIR /root

RUN apk upgrade --update && \
    apk add --update bash ca-certificates wget && \
    rm -rf /var/cache/apk/*

RUN wget https://dl.minio.io/server/minio/release/linux-amd64/minio && \
    chmod +x minio

CMD ["./minio","server","/data/aws_s3"]
