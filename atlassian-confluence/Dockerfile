FROM atlassian/confluence-server:6.15.5-alpine-adoptopenjdk8

ENV MYSQL_DRIVER_VERSION 5.1.47
ENV MYSQL_DRIVER_DOWNLOAD_URL https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_DRIVER_VERSION}.tar.gz

COPY atlassianctl_linux_amd64 /usr/local/bin/atlassianctl

RUN set -x \
    && apk upgrade \
    && apk add tar curl \
    && cd ${CONFLUENCE_INSTALL_DIR}/confluence/WEB-INF/lib/ \
    && curl -sSL ${MYSQL_DRIVER_DOWNLOAD_URL} \
       | tar -xz \
             --directory .  \
             --strip-components=1 \
             --no-same-owner "mysql-connector-java-${MYSQL_DRIVER_VERSION}/mysql-connector-java-${MYSQL_DRIVER_VERSION}-bin.jar" \
    && chmod a+x /usr/local/bin/atlassianctl \
    && atlassianctl crack atlassian-extras-decoder-v*.jar
