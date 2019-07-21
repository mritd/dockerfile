FROM alpine:3.10

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV NETATALK_VERSION 3.1.12
ENV NETATALK_DOWNLOAD_URL https://downloads.sourceforge.net/project/netatalk/netatalk/${NETATALK_VERSION}/netatalk-${NETATALK_VERSION}.tar.gz

RUN set -ex \
    && apk --update upgrade \
    && apk add bash tzdata libldap libgcrypt python \
        dbus dbus-glib py-dbus linux-pam cracklib db \
        libevent file acl openssl avahi runit \
    && apk add --no-cache --virtual .build-deps \
        build-base autoconf automake libtool libgcrypt-dev \
        linux-pam-dev cracklib-dev acl-dev db-dev dbus-dev libevent-dev \
    && wget -q ${NETATALK_DOWNLOAD_URL} \
    && tar -zxf netatalk-${NETATALK_VERSION}.tar.gz \
    && (cd netatalk-${NETATALK_VERSION} \
    && CFLAGS="-Wno-unused-result -O2" ./configure \
        --prefix=/usr \
        --localstatedir=/var/state \
        --sysconfdir=/etc \
        --with-dbus-sysconf-dir=/etc/dbus-1/system.d/ \
        --with-init-style=debian-sysv \
        --sbindir=/usr/bin \
        --enable-quota \
        --with-tdb \
        --enable-silent-rules \
        --with-cracklib \
        --with-cnid-cdb-backend \
        --enable-pgp-uam \
        --with-acls \
    && make && make install) \
    && sed -i 's@#host-name.*@host-name=TimeMachine@g' /etc/avahi/avahi-daemon.conf \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk del .build-deps \
    && rm -rf /netatalk-${NETATALK_VERSION}* \
            /etc/avahi/services/* \
            /var/cache/apk/*

EXPOSE 548 636

COPY entrypoint.sh /entrypoint.sh
COPY conf/afp.conf /etc/afp.conf
COPY conf/afpd.service /etc/avahi/services/afpd.service
COPY services /etc/runit/services

VOLUME ["/data"]

ENTRYPOINT ["/entrypoint.sh"]
