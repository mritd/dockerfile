#!/bin/bash

export JAVA_OPTS="${JAVA_OPTS} -javaagent:${AGENT_PATH}"

# If you want to use SECURE_SMTP, mount the /opt/atlassian/confluence/conf directory
# and follow the link documentation to modify the configuration.
# refs https://confluence.atlassian.com/doc/setting-up-a-mail-session-for-the-confluence-distribution-6328.html
if [ "${JNDI_EMAIL}" == "true" ]; then
    mv ${CONFLUENCE_INSTALL_DIR}/confluence/WEB-INF/lib/javax.mail-*.jar ${CONFLUENCE_INSTALL_DIR}/lib/
fi

/entrypoint.py -fg
