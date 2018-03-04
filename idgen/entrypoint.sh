#!/bin/bash

set -e

echo "init database..."
idgen init
idgen server
