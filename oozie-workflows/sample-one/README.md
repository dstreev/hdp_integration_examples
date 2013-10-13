# Sample Oozie Workflow

## Process

1. Pull two tables from MySql - With Sqoop
    a. Store them as "External Tables", initially.  We'll work into other formats later.
2. Join the two Tables - Hive
3. Email the status of the job.

