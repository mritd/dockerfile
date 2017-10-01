#!/bin/bash

java ${JAVA_OPTS} ${SKYWALKING_COLLECTOR_OPTS} -classpath ${JAVA_CLASSPATH} org.skywalking.apm.collector.boot.CollectorBootStartUp
