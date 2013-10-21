#!/bin/bash

if [ $# < 2 ]; then
  echo "Need to specify a Workflow, an email address, and job (optional) for notifications"
  exit -1;
fi

WORKFLOW=$1
EMAIL=$2

# Default to "job"
JOB=${3:-"job"}

# HDFS hive-site.xml location
HIVE_SITE=${4:-"/user/oozie/share/lib/conf/hive-site.xml"}

APP_PATH=`dirname $0`

echo $APP_PATH

cd $APP_PATH

. $APP_PATH/submit.sh $WORKFLOW

# This can be set by a global variable
OOZIE_URL=http://localhost:11000/oozie

# Submit and Start the job with one call.  To split it out, use submit then start.
oozie job -config $WORKFLOW/$JOB.properties -run -verbose -Demailto=$EMAIL -Duser=$USER -Dhive.site=$HIVE_SITE
