-- Set the database
use ${database};

-- Perform Function
INSERT OVERWRITE TABLE users_desc
SELECT CONCAT(E.FIRST_NAME, " ", E.LAST_NAME), E.CITY, SL.LONG_DESC, E.ZIP_CODE
FROM users E INNER JOIN states_long SL ON E.STATE_CODE = E.STATE_CODE;
