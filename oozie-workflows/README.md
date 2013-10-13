## Tips

Throughout this process, I stumbled on several items that may be of interest to many of you.

| Issue / Concern | Solution |
| Hive Configuration | You will need to include a 'hive-site.xml' for your environment that the Hive action can use.  See my submit.sh scripts for details on how I got a hive-site.xml to the workflow during deployment. |
| Hive 10001 Error | This means that the target table wasn't found.  First place to look is to ensure that the proper "hive-site.xml" is available to the workflow.  I've had my best success with copying a version for your environment into the workflow directory on HDFS and referencing it in your hive action. |
| Details about errors | Start with the Oozie logs.  For more detailed information, you'll need to go to the Fail MR job and drill down into the task logs to get a complete log of the job and failure |
| Passing Variables from Commandline | If you specify variables on the oozie commandline via '-D', they will carry through to the job properties.  See the example of this in 'sample-one' and the 'run-sample.sh' script |
| General Hive in Oozie advise | If you are having issues with Hive in Oozie, the FIRST thing you should do is validate the sql in the Hive command line.  Chasing bad SQL from Oozie is very painful |
| Hive Names | Don't like '-' in names. IE: create database sample-one; FAILS.  Use '_'.  create database sample_two; |
| External Tables | In my sample workflow, I'm using a mizture of EXTERNAL tables in INTERNAL tables.  Just remember that when you DROP a Database (CASCADE), the INTERNAL tables will drop data.  Even when the DATA is NOT in the /apps/hive/warehouse (LOCATION defined). |
| Specifying a Database for Hive in Oozie | The Hive action is basically a copy of the Hive CLI interface.  You can't specify an initial database via the CLI interface.  Although, you can specify an "initialization" script.  Make sure you add a "use xxx;" at the top of each of your scripts to ensure the correct database is being used. Failure to specify this can lead to hive 10001 errors (table not found). |