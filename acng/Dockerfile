FROM sameersbn/apt-cacher-ng

LABEL maintainer="mritd <mritd@linux.com>"

RUN set -ex \
    && apt update \
    && apt install tzdata -y \
    && ln -sf /dev/stdout /var/log/apt-cacher-ng/apt-cacher.log \
    && ln -sf /dev/stderr /var/log/apt-cacher-ng/apt-cacher.err \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apt autoremove -y \
    && apt autoclean -y \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["/usr/sbin/apt-cacher-ng"]
