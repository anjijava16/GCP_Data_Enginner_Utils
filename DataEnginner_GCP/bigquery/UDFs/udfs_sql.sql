# Function:
CREATE OR REPLACE FUNCTION `iwinner-data-318822.welcome.cleanse_string`(text STRING) RETURNS STRING AS (
REGEXP_REPLACE(LOWER(TRIM(text)),'[^a-zA-Z0-9 ]+','')
);

# Example:
SELECT `iwinner-data-318822.welcome.cleanse_string`(country_name) from welcome.data_welcome

# Temp UDF Function 
CREATE TEMP FUNCTION `iwinner-data-318822.welcome.cleanse_string`(text STRING) RETURNS STRING AS (
REGEXP_REPLACE(LOWER(TRIM(text)),'[^a-zA-Z0-9 ]+','')
);

