#!/bin/bash

# Ensure Parent Workflow Directory
hadoop fs -mkdir oozie-workflows

# Remove the old copy
hadoop fs -rmr oozie-workflows/sample-one

# Copy the workflow to hdfs.
hadoop fs -put ../../sample-one oozie-workflows

# For hive Actions to know about there environment, you need to include a hive-site.xml
hadoop fs -put /etc/hive/conf/hive-site.xml oozie-workflows/sample-one/hive

# List the contents
hadoop fs -ls oozie-workflows