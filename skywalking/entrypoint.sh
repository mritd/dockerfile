#!/bin/bash

java ${JAVA_OPTS} ${COLLECTOR_OPTIONS} -classpath ${JAVA_CLASSPATH} org.skywalking.apm.collector.boot.CollectorBootStartUp
