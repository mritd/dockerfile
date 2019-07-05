FROM dchevell/jira-software:7.13.4-alpine

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV AGENT_PATH /opt/atlassian-agent.jar

COPY atlassian-agent.jar ${AGENT_PATH}
COPY hijack.sh /hijack.sh

RUN set -x \
    && apk upgrade \
    && apk add bash tzdata \
    && chown ${RUN_USER}:${RUN_GROUP} ${AGENT_PATH} \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

CMD ["/hijack.sh"]
