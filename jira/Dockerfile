FROM atlassian/jira-software:8.7.1

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV AGENT_PATH /opt/atlassian-agent.jar

COPY atlassian-agent.jar ${AGENT_PATH}
COPY hijack.sh /hijack.sh

RUN set -x \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt update \
    && apt upgrade -y \
    && apt install tzdata -y \
    && chown ${RUN_USER}:${RUN_GROUP} ${AGENT_PATH} \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && apt autoremove -y \
    && apt autoclean -y

CMD ["/hijack.sh"]
