#!/bin/bash

set -e
[[ "${DEBUG}" == "true" ]] && set -x

# check if the `server.xml` file has been changed since the creation of this
# Docker image. If the file has been changed the entrypoint script will not
# perform modifications to the configuration file.
if [ "$(stat -c "%Y" "${CONF_INSTALL}/conf/server.xml")" -eq "0" ]; then
  if [ -n "${X_PROXY_NAME}" ]; then
    xmlstarlet ed --inplace --pf --ps --insert '//Connector[@port="8090"]' --type "attr" --name "proxyName" --value "${X_PROXY_NAME}" "${CONF_INSTALL}/conf/server.xml"
  fi
  if [ -n "${X_PROXY_PORT}" ]; then
    xmlstarlet ed --inplace --pf --ps --insert '//Connector[@port="8090"]' --type "attr" --name "proxyPort" --value "${X_PROXY_PORT}" "${CONF_INSTALL}/conf/server.xml"
  fi
  if [ -n "${X_PROXY_SCHEME}" ]; then
    xmlstarlet ed --inplace --pf --ps --insert '//Connector[@port="8090"]' --type "attr" --name "scheme" --value "${X_PROXY_SCHEME}" "${CONF_INSTALL}/conf/server.xml"
  fi
  if [ -n "${X_PROXY_SECURE}" ]; then
    xmlstarlet ed --inplace --pf --ps --insert '//Connector[@port="8090"]' --type "attr" --name "secure" --value "${X_PROXY_SECURE}" "${CONF_INSTALL}/conf/server.xml"
  fi
  if [ -n "${X_PATH}" ]; then
    xmlstarlet ed --inplace --pf --ps --update '//Context[@docBase="../confluence"]/@path' --value "${X_PATH}" "${CONF_INSTALL}/conf/server.xml"
  fi
fi

if [ -f "${CERTIFICATE}" ]; then
  keytool -noprompt -storepass changeit -keystore ${JAVA_CACERTS} -import -file ${CERTIFICATE} -alias CompanyCA
fi


exec "$@"
