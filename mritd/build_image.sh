#!/bin/bash

(cd idea && docker build -t mritd/idea .)
(cd mritd && docker build -t mritd/mritd .)
(cd nginx && docker build -t mritd/nginx .)
