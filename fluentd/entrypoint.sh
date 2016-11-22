#!/bin/bash

ELASTICSEARCH_HOST=${ELASTICSEARCH_HOST:-es-logging.default.svc}
ELASTICSEARCH_PORT=${ELASTICSEARCH_PORT:-9200}
ELASTICSEARCH_SCHEME=${ELASTICSEARCH_SCHEME:-http}

FLUENTD_FLUSH_INTERVAL=${FLUENTD_FLUSH_INTERVAL:-10s}
FLUENTD_FLUSH_THREADS=${FLUENTD_FLUSH_THREADS:-4}
FLUENTD_RETRY_LIMIT=${FLUENTD_RETRY_LIMIT:-10}
FLUENTD_DISABLE_RETRY_LIMIT=${FLUENTD_DISABLE_RETRY_LIMIT:-true}
FLUENTD_RETRY_WAIT=${FLUENTD_RETRY_WAIT:-1s}
FLUENTD_MAX_RETRY_WAIT=${FLUENTD_MAX_RETRY_WAIT:-60s}
FLUENTD_BUFFER_CHUNK_LIMIT=${FLUENTD_BUFFER_CHUNK_LIMIT:-8m}
FLUENTD_BUFFER_QUEUE_LIMIT=${FLUENTD_BUFFER_QUEUE_LIMIT:-8192}
FLUENTD_BUFFER_TYPE=${FLUENTD_BUFFER_TYPE:-memory}
FLUENTD_BUFFER_PATH=${FLUENTD_BUFFER_PATH:-/var/fluentd/buffer}
FLUENTD_LOGSTASH_FORMAT=${FLUENTD_LOGSTASH_FORMAT:-true}

KUBERNETES_PRESERVE_JSON_LOG=${KUBERNETES_PRESERVE_JSON_LOG:-true}
KUBERNETES_URL=${KUBERNETES_URL:-https://kubernetes.default.svc}
KUBERNETES_VERIFY_SSL=${KUBERNETES_VERIFY_SSL:-true}

mkdir /etc/fluent

cat << EOF >> /etc/fluent/fluent.conf
# input plugin that exports metrics
<source>
  @type prometheus
</source>

# input plugin that collects metrics from MonitorAgent
<source>
  @type prometheus_monitor
</source>

<source>
  @type tail
  path /var/log/containers/*.log
  pos_file /var/log/es-containers.log.pos
  time_format %Y-%m-%dT%H:%M:%S.%N
  tag kubernetes.*
  format json
  read_from_head true
  keep_time_key true
</source>

<filter kubernetes.**>
  @type kubernetes_metadata
  kubernetes_url ${KUBERNETES_URL}
  verify_ssl ${KUBERNETES_VERIFY_SSL}
  preserve_json_log ${KUBERNETES_PRESERVE_JSON_LOG}
</filter>

<filter **>
  @type prometheus

  <metric>
    name fluentd_records_total
    type counter
    desc The total number of records read by fluentd.
  </metric>
</filter>

<match **>
  @type elasticsearch$([ "${ELASTICSEARCH_DYNAMIC}" == "true" ] && echo _dynamic)
  @log_level info
  include_tag_key true
  time_key time
  host ${ELASTICSEARCH_HOST}
  port ${ELASTICSEARCH_PORT}
  scheme ${ELASTICSEARCH_SCHEME}
  $([ -n "${ELASTICSEARCH_USER}" ] && echo user ${ELASTICSEARCH_USER})
  $([ -n "${ELASTICSEARCH_PASSWORD}" ] && echo password ${ELASTICSEARCH_PASSWORD})
  buffer_type ${FLUENTD_BUFFER_TYPE}
  $([ "${FLUENTD_BUFFER_TYPE}" == "file" ] && echo buffer_path ${FLUENTD_BUFFER_PATH})
  buffer_chunk_limit ${FLUENTD_BUFFER_CHUNK_LIMIT}
  buffer_queue_limit ${FLUENTD_BUFFER_QUEUE_LIMIT}
  flush_interval ${FLUENTD_FLUSH_INTERVAL}
  retry_limit ${FLUENTD_RETRY_LIMIT}
  $([ "${FLUENTD_DISABLE_RETRY_LIMIT}" == "true" ] && echo disable_retry_limit)
  retry_wait ${FLUENTD_RETRY_WAIT}
  max_retry_wait ${FLUENTD_MAX_RETRY_WAIT}
  num_threads ${FLUENTD_FLUSH_THREADS}
  logstash_format ${FLUENTD_LOGSTASH_FORMAT}
  $([ -n "${FLUENTD_LOGSTASH_PREFIX}" ] && echo logstash_prefix ${FLUENTD_LOGSTASH_PREFIX})
  reload_connections false
EOF

cat << 'EOF' >> /etc/fluent/fluent.conf
</match>
EOF

echo "Start fluentd..."

fluentd
