#!/bin/bash

set -e

sed -i "s@{{ADDRESS}}@${ADDRESS}@g" /usr/share/nginx/html/index.html
sed -i "s@{{PORT}}@${PORT}@g" /usr/share/nginx/html/index.html
sed -i "s@{{SECRET}}@${SECRET}@g" /usr/share/nginx/html/index.html

nginx -g "daemon off;"
