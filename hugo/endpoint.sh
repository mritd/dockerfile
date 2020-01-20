#!/bin/bash

set -e

git clone -b gh-pages https://github.com/mritd/mritd.com.git /usr/share/nginx/html

echo "blog starting..."

httpcmd -r ^git.* -t ${HTTPCMD_TOKEN} -w /usr/share/nginx/html -d
nginx -g "daemon off;"
