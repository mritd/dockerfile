FROM debian:jessie 

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TZ 'Asia/Shanghai'

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install sudo wget curl netcat hping3 stunnel whois ike-scan nmap tzdata -y \
    && wget https://raw.githubusercontent.com/GinjaChris/pentmenu/master/pentmenu -O /usr/local/bin/pentmenu \
    && chmod +x /usr/local/bin/pentmenu \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apt-get clean

CMD ["/bin/bash"]
