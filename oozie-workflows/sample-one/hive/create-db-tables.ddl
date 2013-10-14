-- Setup Database;
DROP DATABASE IF EXISTS ${database} CASCADE;
create database ${database};
use ${database};

-- Entity Table
CREATE TABLE IF NOT EXISTS users (
ID INT,
FIRST_NAME STRING,
LAST_NAME STRING,
STATE_CODE STRING,
CITY STRING,
ZIP_CODE STRING
);
-- STORED AS orc tblproperties ("orc.compress"="NONE");
-- ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
-- LOCATION '/user/${user}/users';

-- State Long Description Table
CREATE EXTERNAL TABLE IF NOT EXISTS states_long (
LONG_DESC STRING,
STATE_CODE STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LOCATION '/user/${user}/states';
-- STORED as orc tblproperties ("orc.compress"="NONE");

-- Long State Joined.
CREATE TABLE IF NOT EXISTS users_desc (
FULL_NAME STRING,
CITY STRING,
STATE STRING,
ZIP_CODE STRING
);

CREATE TABLE IF NOT EXISTS summary_table (
ZIP_CODE STRING,
ENTITY_COUNT INT
);


