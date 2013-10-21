#!/bin/bash

if [ $# < 3 ]; then
  echo "Need to specify a Workflow, Job and an email address for notifications"
  exit -1;
fi

# HDFS hive-site.xml location
HIVE_SITE=${4:-"/hdp_1.3.2/share/lib/conf/hive-site.xml"}

APP_PATH=`dirname $0`
echo $APP_PATH

cd $APP_PATH

. $APP_PATH/submit.sh $1

# Submit and Start the job with one call.  To split it out, use submit then start.
oozie job -oozie http://localhost:11000/oozie -config $1/$2.properties -run -verbose -Demailto=$3 -Duser=$USER -Dhive.site=$HIVE_SITE
