#!/bin/bash

set -e

google-chrome-stable \
    --disable-gpu \
    --headless \
    --no-sandbox \
    --remote-debugging-address=0.0.0.0 \
    --remote-debugging-port=9222 \
    --user-data-dir=/data $@
