#!/bin/bash
cd /data/repo/centos/7/ && ls | xargs -i createrepo --update {}
