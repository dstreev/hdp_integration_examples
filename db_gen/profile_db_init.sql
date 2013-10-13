DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;

CREATE TABLE sample_oozie.users (
  id MEDIUMINT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  state_code CHAR(2),
  city VARCHAR(100),
  zipcode int(5),
  PRIMARY KEY (id)
);

CREATE TABLE sample.states (
  state VARCHAR(100),
  state_code CHAR(2)
);
GRANT ALL PRIVILEGES on sample.* TO 'sample'@'localhost' IDENTIFIED BY 'sample' WITH GRANT OPTION;
