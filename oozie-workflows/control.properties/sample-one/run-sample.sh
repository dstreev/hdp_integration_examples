#!/bin/bash

if [ $# != 1 ]; then
  echo "Need to specify an email address for notifications"
  exit -1;
fi

APP_PATH=`dirname $0`
echo $APP_PATH

cd $APP_PATH

. $APP_PATH/submit.sh

# Submit and Start the job with one call.  To split it out, use submit then start.
oozie job -oozie http://localhost:11000/oozie -config job.properties -run -verbose -Demailto=$1 -Duser=$USER
