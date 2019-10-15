#!/bin/bash

set -e

git clone -b gh-pages https://github.com/mritd/mritd.com.git /usr/share/nginx/html

echo "blog starting..."

nginx -g "daemon off;"
