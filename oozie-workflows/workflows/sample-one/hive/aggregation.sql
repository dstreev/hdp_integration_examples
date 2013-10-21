-- Set the database
use ${database};

-- Perform Function
INSERT OVERWRITE TABLE summary_table
SELECT E.ZIP_CODE, COUNT(*) FROM users_desc E GROUP BY E.ZIP_CODE;
