#/bin/bash

set -e

if [ "" != "$!" ];then
    ./ngrok $@
else
    ./ngrok -tlsKey=/etc/nginx/ssl/mritd.me.key -tlsCrt=/nginx/ssl/mritd.me.crt -domain="ngrok.mritd.me" -httpAddr=":80" -httpsAddr=":443"
fi
