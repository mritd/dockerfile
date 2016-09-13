#!/bin/bash

if [ "$1" == "nocache" ];then
  (cd idea && docker build --no-cache -t mritd/idea .) 
  (cd mritd && docker build --no-cache -t mritd/mritd .)
  (cd nginx && docker build --no-cache -t mritd/nginx .)
else
  (cd idea && docker build -t mritd/idea .)
  (cd mritd && docker build -t mritd/mritd .)
  (cd nginx && docker build -t mritd/nginx .)
fi

