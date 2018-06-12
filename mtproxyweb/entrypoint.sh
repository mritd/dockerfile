#!/bin/bash

set -e

sed -i "s@{{MT_ADDRESS}}@${MT_ADDRESS}@g" /usr/share/nginx/html/index.html
sed -i "s@{{MT_PORT}}@${MT_PORT}@g" /usr/share/nginx/html/index.html
sed -i "s@{{MT_SECRET}}@${MT_SECRET}@g" /usr/share/nginx/html/index.html

nginx -g "daemon off;"
