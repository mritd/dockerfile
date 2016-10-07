#!/bin/bash

docker-compose down
git pull
./build_images.sh
docker-compose up -d
docker-compose ps
