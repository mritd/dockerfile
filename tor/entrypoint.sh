#!/bin/bash

chown tor:nogroup /var/log/tor/notices.log
su-exec tor tor
