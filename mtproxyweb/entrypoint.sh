#!/bin/bash

set -e

sed -i "s@{{ADDRESS}}@${SECRET}@g" /usr/share/nginx/html/index.html
sed -i "s@{{PORT}}@${SECRET}@g" /usr/share/nginx/html/index.html
sed -i "s@{{SECRET}}@${SECRET}@g" /usr/share/nginx/html/index.html

nginx -g "daemon off;"
