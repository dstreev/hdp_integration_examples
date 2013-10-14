## Tips

Throughout this process, I stumbled on several items that may be of interest to many of you.

<table>
<tr>
<th>Issue / Concern</th>
<th>Solution</th>
</tr><tr><td>
Sqoop Import to Hive Table in ORC Format
</td><td>
Doesn't work with HDP 1.3.2.  The Sqoop-Hive process is actually done in two steps.

1. Sqoop to HDFS
2. Sqoop Call Hive CLI to create table, then moves data to table location with a "LOAD DATA INPATH" command. This doesn't
convert to format.  So the ORC target format isn't honored.  This might also be true for "rc" files as well.

According to "Programming Hive" page 73, Hive doesn't verify that the data being loaded matches the predefined schema.
It will check that to file format matches, IE: table is a SEQUENCEFILE so should the imported data.

That may be true, but it doesn't fail for the "orc" defined table (the action will succeed) and your table will be corrupt.

If you are going from Sqoop to a Hive Table in "orc" format, you need to do it through an intermediate table (external)
in the default hive format.  Then use another Oozie action to load the table via a hive script that does an:
 <pre>
   FROM staging_table st
   insert into table target_table
   SELECT ...
 </pre>
</td></tr><tr><td>
Specifying a Database for Sqoop - Hive Import
</td><td>
Use "." notation and prefix the table name with the database name.

There isn't a "hive-database" like argument that can be set for the job.
</td></tr><tr><td>
JA008 Error
</td><td>
Your libraries aren't being loading.  Ensure you have the correct version of your libraries on HDFS and your Oozie-site.xml file is pointing to the correct location.
<p>Add oozie.use.system.libpath=true to your job properties files.</p>
<p>Unzip and upload the $OOZIE_HOME/oozie-sharelib... to an **HDFS** directory that matches the value below in oozie-site.xml</p>
<p>oozie-site.xml</p>
<br>oozie.service.WorkflowAppService.system.libpath</p>
</td></tr><tr><td>
Sqoop DB Drivers
</td><td>
Need to be uploaded to the above sharelib directory under "sqoop" to make it available to sqoop jobs.
</td></tr><tr><td>
Beware the Sandbox
</td><td>
When you do fork/join in Oozie, it will hang if you only have 2 mapper slots available. I deadlock situation occurs because there are not enough slots to process the job and the fork/join.
</td></tr><tr><td>
Hive Configuration
</td><td>
You will need to include a 'hive-site.xml' for your environment that the Hive action can use.  See my submit.sh scripts for details on how I got a hive-site.xml to the workflow during deployment.
</td></tr><tr><td>
Hive 10001 Error
</td><td>
This means that the target table wasn't found.  First place to look is to ensure that the proper "hive-site.xml" is available to the workflow.  I've had my best success with copying a version for your environment into the workflow directory on HDFS and referencing it in your hive action.
</td></tr><tr><td>
Details about errors
</td><td>
Start with the Oozie logs.  For more detailed information, you'll need to go to the Fail MR job and drill down into the task logs to get a complete log of the job and failure
</td></tr><tr><td>
Passing Variables from Commandline
</td><td>
If you specify variables on the oozie commandline via '-D', they will carry through to the job properties.  See the example of this in 'sample-one' and the 'run-sample.sh' script
</td></tr><tr><td>
General Hive in Oozie advise
</td><td>
If you are having issues with Hive in Oozie, the FIRST thing you should do is validate the sql in the Hive command line.  Chasing bad SQL from Oozie is very painful
</td></tr><tr><td>
Hive Names
</td><td>
Don't like '-' in names. IE: create database sample-one; FAILS.  Use '_'.  create database sample_two;
</td></tr><tr><td>
External Tables
</td><td>
In my sample workflow, I'm using a mizture of EXTERNAL tables in INTERNAL tables.  Just remember that when you DROP a Database (CASCADE), the INTERNAL tables will drop data.  Even when the DATA is NOT in the /apps/hive/warehouse (LOCATION defined).
</td></tr><tr><td>
Don't forget to upload your workflow app.
</td><td>
During development it's easy to get caught up in rapid changes.  Remember, the oozie workflow application needs to be updated on HDFS, otherwise you won't see your changes.  I write a script that cleans up, deploys and run's the workflow for development and rapid testing.
</td></tr><tr><td>
Specifying a Database for Hive in Oozie
</td><td>
The Hive action is basically a copy of the Hive CLI interface.  You can't specify an initial database via the CLI interface.  Although, you can specify an "initialization" script.  Make sure you add a "use xxx;" at the top of each of your scripts to ensure the correct database is being used. Failure to specify this can lead to hive 10001 errors (table not found).
</td></tr>
</table>