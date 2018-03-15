FROM python:3.6.4-jessie 

LABEL maintainer="mritd <mritd1234@gmail.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV TAIGA_BACK_VERSION 3.2.0
ENV TAIGA_DOWNLOAD_URL https://github.com/taigaio/taiga-back/archive/${TAIGA_BACK_VERSION}.tar.gz

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y wget tar unzip tzdata locales gettext ca-certificates \
    && pip install --upgrade setuptools \
    && locale-gen --purge en_US.UTF-8 zh_CN.UTF-8 \
    && echo 'LANG=en_US.UTF-8' > /etc/default/locale \
    && echo 'LANGUAGE=en_US:en' >> /etc/default/locale \
    && echo 'LC_TYPE=en_US.UTF-8' >> /etc/default/locale \
    && echo 'LC_MESSAGES=POSIX' >> /etc/default/locale


RUN wget ${TAIGA_DOWNLOAD_URL} \
    && tar -zxvf ${TAIGA_BACK_VERSION}.tar.gz \
    && mv taiga-back-${TAIGA_BACK_VERSION} /usr/local/taiga-back \
    && (cd /usr/local/taiga-back \
    && pip install --no-cache-dir -r requirements.txt \
    && python manage.py collectstatic --noinput) \
    && rm -rf ${TAIGA_BACK_VERSION}.tar.gz \
            /var/lib/apt/lists/*

WORKDIR /usr/local/taiga-back

CMD ["python","manage.py","runserver"]
