#!/bin/bash

set -e

git pull
nginx -g "daemon off;"
