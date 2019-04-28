FROM python:3.6.4-jessie 

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV TAIGA_BACK_VERSION 3.2.0
ENV TAIGA_BACK_HOME /usr/local/taiga-back
ENV TAIGA_DOWNLOAD_URL https://github.com/taigaio/taiga-back/archive/${TAIGA_BACK_VERSION}.tar.gz

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y wget tar unzip tzdata locales gettext ca-certificates \
    && pip install --upgrade setuptools \
    && locale-gen --purge en_US.UTF-8 zh_CN.UTF-8 \
    && echo 'LANG=en_US.UTF-8' > /etc/default/locale \
    && echo 'LANGUAGE=en_US:en' >> /etc/default/locale \
    && echo 'LC_TYPE=en_US.UTF-8' >> /etc/default/locale \
    && echo 'LC_MESSAGES=POSIX' >> /etc/default/locale \
    && wget ${TAIGA_DOWNLOAD_URL} \
    && tar -zxvf ${TAIGA_BACK_VERSION}.tar.gz \
    && mv taiga-back-${TAIGA_BACK_VERSION} ${TAIGA_BACK_HOME} \
    && (cd /usr/local/taiga-back \
    && pip install --no-cache-dir -r requirements.txt \
    && python manage.py collectstatic --noinput) \
    && apt remove -y unzip \
    && rm -rf ${TAIGA_BACK_VERSION}.tar.gz \
            /var/lib/apt/lists/*

WORKDIR ${TAIGA_BACK_HOME}

EXPOSE 8000 9001

CMD ["python","manage.py","runserver","0.0.0.0:8000"]
