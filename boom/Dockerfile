FROM ubuntu:16.04

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y tzdata wget curl netcat hping3 openssl stunnel \
        nmap whois ike-scan dnsutils sudo \
    && wget https://raw.githubusercontent.com/GinjaChris/pentmenu/master/pentmenu -O /usr/local/bin/pentmenu \
    && chmod +x /usr/local/bin/pentmenu \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone

CMD ["/bin/bash"]
