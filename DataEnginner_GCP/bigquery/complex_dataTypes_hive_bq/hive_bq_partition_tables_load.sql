create database iwinner_db;
 
use iwinner_db;
CREATE external TABLE sales_info (location string, month string,
number_of_orders int, total_sales double)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS textfile
LOCATION 'gs://dev-iwinner-data-july04/hive_data/text/';



CREATE external TABLE partition_sales (location string, month string,
number_of_orders int, total_sales double)
partitioned by (process_dt string) 
 STORED AS PARQUET
LOCATION 'gs://dev-iwinner-data-july04/hive_data/partition/parquet/';


insert into table partition_sales partition(process_dt='2021-08-25') select * from sales_info;

CREATE external TABLE welcome_partition_two_columns (location string, month string,
number_of_orders int, total_sales double)
partitioned by (process_dt string,code string) 
 STORED AS PARQUET
LOCATION 'gs://dev-iwinner-data-july04/hive_data/partition_two/parquet/';


insert into table welcome_partition_two_columns partition(process_dt='2021-08-25',code='DE') select * from sales_info;
insert into table welcome_partition_two_columns partition(process_dt='2021-08-25',code='PA') select * from sales_info;
insert into table welcome_partition_two_columns partition(process_dt='2021-08-25',code='NY') select * from sales_info;
insert into table welcome_partition_two_columns partition(process_dt='2021-08-25',code='HY') select * from sales_info;


bq mkdef --source_format=PARQUET --hive_partitioning_mode=AUTO --hive_partitioning_source_uri_prefix=gs://dev-iwinner-data-july04 gs://dev-iwinner-data-july04/hive_data/partition_two/parquet/* 

mamathamams39@cluster-365c-m:~$ bq mkdef --source_format=PARQUET --hive_partitioning_mode=AUTO --hive_partitioning_source_uri_prefix=gs://dev-iwinner-data-july04 gs://dev-iwinner-data-july04/hive_data/partition_two/parquet/*
{
  "hivePartitioningOptions": {
    "mode": "AUTO", 
    "sourceUriPrefix": "gs://dev-iwinner-data-july04"
  }, 
  "parquetOptions": {
    "enableListInference": false, 
    "enumAsString": false
  }, 
  "sourceFormat": "PARQUET", 
  "sourceUris": [
    "gs://dev-iwinner-data-july04/hive_data/partition_two/parquet/*"
  ]
}mamathamams39@cluster-365c-m:~$



bq mkdef --source_format=PARQUET --hive_partitioning_mode=AUTO --hive_partitioning_source_uri_prefix=gs://dev-iwinner-data-july04/hive_data/partition_two/parquet/ gs://dev-iwinner-data-july04/hive_data/partition_two/parquet/*  >res


bq mk --external_table_definition=/home/mamathamams39/res welcome.welcome_partition_two_columns




bq mkdef --source_format=PARQUET --hive_partitioning_mode=STRINGS --hive_partitioning_source_uri_prefix=gs://dev-iwinner-data-july04/hive_data/partition_two/parquet/ gs://dev-iwinner-data-july04/hive_data/partition_two/parquet/*  >resstr


bq mk --external_table_definition=/home/mamathamams39/resstr welcome.welcome_partition_two_columns_str


CREATE external TABLE two_partition_cols_orc (location string, month string,
number_of_orders int, total_sales double)
partitioned by (process_dt string,code string) 
 STORED AS ORC
LOCATION 'gs://dev-iwinner-data-july04/hive_data/two_partition_cols_orc/';


set hive.exec.dynamic.partition.mode=nonstrict;
INSERT INTO two_partition_cols_orc partition(process_dt,code) select * from welcome_partition_two_columns;



bq mkdef --source_format=ORC --hive_partitioning_mode=STRINGS --hive_partitioning_source_uri_prefix=gs://dev-iwinner-data-july04/hive_data/two_partition_cols_orc/ gs://dev-iwinner-data-july04/hive_data/two_partition_cols_orc/*  >res_orc


bq mk --external_table_definition=/home/mamathamams39/res_orc welcome.welcome_partition_two_columns_orc



