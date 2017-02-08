#!/bin/bash

set -e

if [ $# -eq 0 ] ; then
	echo "Usage: ./update.sh <docker/distribution tag or branch>"
	exit
fi

VERSION=$1

# cd to the current directory so the script can be run from anywhere.
cd `dirname $0`

echo "Fetching and building distribution $VERSION..."

# Create a temporary directory.
TEMP=`mktemp -d /$TMPDIR/distribution.XXXXXX`

git clone -b $VERSION https://github.com/docker/distribution.git $TEMP
docker build -t distribution-builder $TEMP

# Create a dummy distribution-build container so we can run a cp against it.
ID=$(docker create distribution-builder)

# Update the local binary and config.
docker cp $ID:/go/bin/registry registry
docker cp $ID:/go/src/github.com/docker/distribution/cmd/registry/config-example.yml registry

# Cleanup.
docker rm -f $ID
docker rmi distribution-builder

echo "Done."
