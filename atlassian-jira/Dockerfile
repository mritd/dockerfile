FROM dchevell/jira-software:7.13.4-alpine

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

COPY atlassianctl_linux_amd64 /usr/local/bin/atlassianctl

RUN set -x \
    && apk upgrade \
    && apk add bash tzdata \
    && cd ${JIRA_INSTALL_DIR}/atlassian-jira/WEB-INF/lib/ \
    && atlassianctl crack atlassian-extras-3.2.jar \
    && chown -R ${RUN_USER}:${RUN_GROUP} ${CONFLUENCE_INSTALL_DIR} \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*
