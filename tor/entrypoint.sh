#!/bin/bash

chown tor:nogroup /var/log/tor/notices.log
gosu tor tor
