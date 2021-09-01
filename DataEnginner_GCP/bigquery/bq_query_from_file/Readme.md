# Command:
1. bq query --use_legacy_sql=false <C:/Tech_Learn_welcome/welcome/welcome.sql

# welcome.sql
``
SELECT
  word,
  SUM(word_count) AS count
FROM
  `bigquery-public-data`.samples.shakespeare
WHERE
  word LIKE "%raisin%"
GROUP BY
  word;

``


