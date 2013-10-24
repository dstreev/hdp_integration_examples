# Loading the Datasets

The datasets are "mysql" dumps of databases in MySQL.  Install and configure MySQL and use the mysql "cli" to load
the dataset onto MySQL.

1. Get a copy of the dataset.
2. Expand dataset locally.
2. Create a target database in MySQL

`mysql -uroot
`mysql> create database xxx;
`mysql> use database xxx;
`-- Load Dataset to MySQL
`mysql> \. /tmp/sample_one.mysqldump
