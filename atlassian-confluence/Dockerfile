FROM atlassian/confluence-server:6.15.6

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

ENV MYSQL_DRIVER_VERSION 5.1.47
ENV MYSQL_DRIVER_DOWNLOAD_URL https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_DRIVER_VERSION}.tar.gz

COPY atlassianctl_linux_amd64 /usr/local/bin/atlassianctl

RUN set -x \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt update \
    && apt update -y \
    && apt install tzdata -y \
    && curl -sSL ${MYSQL_DRIVER_DOWNLOAD_URL} | tar -xz --strip-components=1 --directory "${CONFLUENCE_INSTALL_DIR}/confluence/WEB-INF/lib" --no-same-owner "mysql-connector-java-${MYSQL_DRIVER_VERSION}/mysql-connector-java-${MYSQL_DRIVER_VERSION}-bin.jar" \
    && chown -R ${RUN_USER}:${RUN_GROUP} ${CONFLUENCE_INSTALL_DIR} \
    && cd ${CONFLUENCE_INSTALL_DIR}/confluence/WEB-INF/lib/ \
    && atlassianctl crack atlassian-extras-decoder-v*.jar \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && apt autoremove -y \
    && apt autoclean -y
