#!/bin/bash


EMAIL=$1

APP_PATH=`dirname $0`

cd $APP_PATH

. $APP_PATH/submit.sh coord-one

# This can be set by a global variable
OOZIE_URL=http://$HOSTNAME:11000/oozie

# Submit and Start the job with one call.  To split it out, use submit then start.
oozie job -config job.properties -run -verbose -Demailto=$EMAIL -Duser=$USER -Dhive.site=$HIVE_SITE -Dhost=$HOSTNAME -Ddtg=`date "+%Y-%m-%dT%H:%MZ"`
