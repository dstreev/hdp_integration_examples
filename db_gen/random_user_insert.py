#!/usr/bin/env python

"""
Purpose: This script is designed to run after the inital gen_mysql_content.py. 
      This will facilitate the oozie coordinator example that will
      append new rows to a Hive staging table and further to a Hive table.
Use:  Run from cron to insert a random number of users at cron interval.
      The first argument is the number of users to insert.
"""
import sys
import random

from gen_mysql_content import Mgen


if __name__ == "__main__":
    if len(sys.argv) >= 2:
        #the user has the option to specify a user count in the first argument.
        #if not, generate a radom one 1-100
        try:
            users_count = int(sys.argv[1])
        except:
            print "Did not supply an integer... Generating random user count.."
            users_count = random.randrange(1, 100, 1)
    else:
        users_count = random.randrange(1, 100, 1)

    print "Attempting insert of %d users" % (users_count)

    runner = Mgen()
    runner.generate_users_table(rowcount=users_count)
