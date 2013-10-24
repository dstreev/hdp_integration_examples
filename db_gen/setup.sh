#!/bin/bash

#This script will setup the sample database environment
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


echo "Initializing the database"
mysql < $DIR/profile_db_init.sql

echo "Ingesting sample data"
/usr/bin/python $DIR/gen_mysql_content.py

echo "Add entry to /etc/cron.d for random user ingest every 1 minute"
su -c "echo '*/1 * * * * root /usr/bin/python $DIR/random_user_insert.py' > /etc/cron.d/sample_random_users" root
echo "Change perms on cron job"
su -c "chmod 644 /etc/cron.d/sample_random_users" root
