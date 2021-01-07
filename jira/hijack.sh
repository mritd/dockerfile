#!/bin/bash

export JAVA_OPTS="${JAVA_OPTS} -javaagent:${AGENT_PATH}"

/entrypoint.py
