FROM openjdk:8-alpine

# Setup useful environment variables
ENV CONF_HOME=/var/atlassian/confluence \
    CONF_INSTALL=/opt/atlassian/confluence \
    JAVA_CACERTS=$JAVA_HOME/jre/lib/security/cacerts \
    CERTIFICATE=$CONF_HOME/certificate \
    MYSQL_connector=5.1.47 \
    CONF_VERSION=6.14.3 JAVA_OPTS='-Duser.timezone=GMT+08'

# Install Atlassian Confluence and helper tools and setup initial home
# directory structure.
COPY atlassianctl_linux_amd64 /usr/local/bin/atlassianctl

RUN set -x \
    && apk --no-cache add curl xmlstarlet bash ttf-dejavu libc6-compat \
    && mkdir -p                "${CONF_HOME}" \
    && chmod -R 700            "${CONF_HOME}" \
    && chown daemon:daemon     "${CONF_HOME}" \
    && mkdir -p                "${CONF_INSTALL}/conf" \
    && curl -Ls                "https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-${CONF_VERSION}.tar.gz" | tar -xz --directory "${CONF_INSTALL}" --strip-components=1 --no-same-owner \
    && curl -Ls                "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_connector}.tar.gz" | tar -xz --directory "${CONF_INSTALL}/confluence/WEB-INF/lib" --strip-components=1 --no-same-owner "mysql-connector-java-${MYSQL_connector}/mysql-connector-java-${MYSQL_connector}-bin.jar" \
    && chmod -R 700            "${CONF_INSTALL}/conf" "${CONF_INSTALL}/temp" "${CONF_INSTALL}/logs" "${CONF_INSTALL}/work"\
    && chown -R daemon:daemon  "${CONF_INSTALL}/conf" "${CONF_INSTALL}/work" "${CONF_INSTALL}/temp" "${CONF_INSTALL}/logs" \
    && echo -e                 "\nconfluence.home=$CONF_HOME" >> "${CONF_INSTALL}/confluence/WEB-INF/classes/confluence-init.properties" \
    && xmlstarlet              ed --inplace \
        --delete               "Server/@debug" \
        --delete               "Server/Service/Connector/@debug" \
        --delete               "Server/Service/Connector/@useURIValidationHack" \
        --delete               "Server/Service/Connector/@minProcessors" \
        --delete               "Server/Service/Connector/@maxProcessors" \
        --delete               "Server/Service/Engine/@debug" \
        --delete               "Server/Service/Engine/Host/@debug" \
        --delete               "Server/Service/Engine/Host/Context/@debug" \
                               "${CONF_INSTALL}/conf/server.xml" \
    && touch -d "@0"           "${CONF_INSTALL}/conf/server.xml" \
    && sed -ri 's#-Xms1024m -Xmx1024m#$JVM_MEMORY#' $CONF_INSTALL/bin/setenv.sh \
    && chown daemon:daemon     "${JAVA_CACERTS}" \
    && cd ${CONF_INSTALL}/confluence/WEB-INF/lib/ \
    && chmod a+x /usr/local/bin/atlassianctl \
    && atlassianctl crack atlassian-extras-decoder-v*.jar

# Use the default unprivileged account. This could be considered bad practice
# on systems where multiple processes end up being executed by 'daemon' but
# here we only ever run one process anyway.
USER daemon:daemon

# Expose default HTTP connector port.
EXPOSE 8090 8091

# Set volume mount points for installation and home directory. Changes to the
# home directory needs to be persisted as well as parts of the installation
# directory due to eg. logs.
VOLUME ["/var/atlassian/confluence", "/opt/atlassian/confluence/logs"]

# Set the default working directory as the Confluence home directory.
WORKDIR /var/atlassian/confluence

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

# Run Atlassian Confluence as a foreground process by default.
CMD ["/opt/atlassian/confluence/bin/start-confluence.sh", "-fg"]
