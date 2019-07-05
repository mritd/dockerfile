FROM atlassian/confluence-server:6.15.6

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

COPY atlassianctl_linux_amd64 /usr/local/bin/atlassianctl

RUN set -x \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt update \
    && apt upgrade -y \
    && apt install tzdata -y \
    && cd ${CONFLUENCE_INSTALL_DIR}/confluence/WEB-INF/lib/ \
    && atlassianctl crack atlassian-extras-decoder-v*.jar \
    && chown -R ${RUN_USER}:${RUN_GROUP} ${CONFLUENCE_INSTALL_DIR} \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && apt autoremove -y \
    && apt autoclean -y
