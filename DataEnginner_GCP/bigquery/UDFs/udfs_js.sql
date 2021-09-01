# Peristance UDF 
CREATE  OR REPLACE  FUNCTION welcome.udf_js(a STRING)
RETURNS STRING
LANGUAGE js AS """
 return "Hello, " + a + "!";
 """;

# Temp UDF 
CREATE TEMPORARY FUNCTION greeting(a STRING)
RETURNS STRING
LANGUAGE js AS """
 return "Hello, " + a + "!";
 """;
SELECT greeting(country) as everyone
FROM welcome.welcome_target
