#!/bin/bash

git clone -b gh-pages https://github.com/mritd/mritd.com.git /usr/share/nginx/html

nginx -g "daemon off;"
