FROM alpine:3.4

MAINTAINER mritd <mritd@mritd.me>

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --update && \
    apk add --update bash && \
    rm -rf /var/cache/apk/*

CMD ["/bin/bash"]
