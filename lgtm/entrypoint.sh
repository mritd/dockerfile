#!/bin/bash

lgtm -token $LGTM_TOKEN \
     -gitlab_url $LGTM_GITLAB_URL \
     -lgtm_count $LGTM_COUNT \
     -lgtm_note $LGTM_NOTE \
     -log_level $LGTM_LOG_LEVEL \
     -db_path $LGTM_DB_PATH \
     -port $LGTM_PORT
