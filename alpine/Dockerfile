FROM alpine:3.3

MAINTAINER mritd <mritd@mritd.me>

RUN apk upgrade --update && \
    apk add --update bash && \
    rm -rf /var/cache/apk/*

CMD ["/bin/bash"]
