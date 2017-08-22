FROM alpine:3.5

LABEL maintainer="mritd <mritd1234@gmail.com>"

ENV TZ 'Asia/Shanghai'

ENV NETATALK_VERSION 3.1.10

RUN apk --update upgrade \
    && apk add bash tzdata libldap libgcrypt python \
        dbus dbus-glib py-dbus linux-pam cracklib db \
        libevent file acl openssl \
    && apk add --no-cache --virtual .build-deps \
        build-base autoconf automake libtool libgcrypt-dev \
        linux-pam-dev cracklib-dev acl-dev db-dev dbus-dev libevent-dev \
    && wget https://downloads.sourceforge.net/project/netatalk/netatalk/${NETATALK_VERSION}/netatalk-${NETATALK_VERSION}.tar.gz \
    && tar -zxvf netatalk-${NETATALK_VERSION}.tar.gz \
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
    && rm -rf ../netatalk-${NETATALK_VERSION}* \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/*

EXPOSE 548 636

COPY entrypoint.sh /entrypoint.sh

COPY afp.conf /etc/afp.conf

VOLUME ["/data"]

ENTRYPOINT ["/entrypoint.sh"]
