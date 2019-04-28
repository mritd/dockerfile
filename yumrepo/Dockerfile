FROM centos:7

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV UPX_VERSION 0.2.3
ENV UPX_DOWNLOAD_URL http://collection.b0.upaiyun.com/softwares/upx/upx-linux-amd64-v${UPX_VERSION}

RUN yum update -y \
    && yum upgrade -y \
    && yum install tzdata createrepo wget -y \
    && wget ${UPX_DOWNLOAD_URL} -O /usr/local/bin/upx \
    && chmod +x /usr/local/bin/upx \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone

CMD ["/bin/bash"]
