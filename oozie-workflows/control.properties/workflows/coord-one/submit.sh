#!/bin/bash

BASE_WF_DIR=oozie-workflows

WORK_FLOW=coord-one
# Ensure Parent Workflow Directory
hadoop fs -mkdir $BASE_WF_DIR

# Remove the old copy
hadoop fs -rm -R  $BASE_WF_DIR/$WORK_FLOW

# Copy the workflow to hdfs.
hadoop fs -put ../../../workflows/$WORK_FLOW $BASE_WF_DIR

hadoop fs -put /etc/sqoop/conf/sqoop-site.xml oozie-workflows/$WORK_FLOW/sqoop

# List the contents
hadoop fs -ls $BASE_WF_DIR/$WORK_FLOW
