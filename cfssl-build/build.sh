#!/usr/bin/env bash

set -ex

SOURCE_DIR='/go/src/github.com/cloudflare/cfssl'

git clone https://github.com/cloudflare/cfssl.git ${SOURCE_DIR}

cd ${SOURCE_DIR} && make package-deb && mv *.deb /dist/
