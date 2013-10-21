#!/bin/bash

BASE_WF_DIR=oozie-workflows

WORK_FLOW=$1
# Ensure Parent Workflow Directory
hadoop fs -mkdir $BASE_WF_DIR

# Remove the old copy
hadoop fs -rmr $BASE_WF_DIR/$WORK_FLOW

# Copy the workflow to hdfs.
hadoop fs -put ../../workflows/$WORK_FLOW $BASE_WF_DIR

# For hive Actions to know about there environment, you need to include a hive-site.xml
#hadoop fs -put /etc/hive/conf/hive-site.xml oozie-workflows/sample-one/hive

# List the contents
hadoop fs -ls $BASE_WF_DIR/$WORK_FLOW