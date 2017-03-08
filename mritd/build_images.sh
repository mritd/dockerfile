#!/bin/bash

if [ "$1" == "-f" ];then
  (cd idea && docker build --no-cache -t mritd/idea .) 
  (cd jekyll && docker build --no-cache -t mritd/jekyll .)
  (cd nginx && docker build --no-cache -t mritd/nginx .)
  (cd gcr-registry && docker build --no-cache -t mritd/gcr.io .)
  (cd yum && docker build --no-cache -t mritd/yum .)
else
  (cd idea && docker build -t mritd/idea .)
  (cd jekyll && docker build -t mritd/jekyll .)
  (cd nginx && docker build -t mritd/nginx .)
  (cd gcr-registry && docker build -t mritd/gcr.io .)
  (cd yum && docker build -t mritd/yum .)
fi

