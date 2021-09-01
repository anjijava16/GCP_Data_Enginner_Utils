CREATE OR REPLACE TABLE staging.employee_tbl_partition
(
id STRING,
name STRING,
job STRING,
address STRING,
email STRING,
process_date date 
)
PARTITION BY process_date
cluster by id
OPTIONS (
partition_expiration_days=999999,
require_partition_filter=true
)

