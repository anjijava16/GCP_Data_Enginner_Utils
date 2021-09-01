from __future__ import print_function
import tempfile
from pyspark.sql import SparkSession
from pyspark.sql import functions as F
from pyspark.sql.functions import col
from pyspark.sql.functions import *
from pyspark.sql.types import StringType,BooleanType,DateType
from pyspark.sql.types import DateType


spark = SparkSession.builder.appName('covid19_jhu').enableHiveSupport().getOrCreate()
df = spark.read.option("header","true").csv('gs://iwinner-data/data/bq_input/input.csv')
print("First DF ")
df.printSchema()
df.show(10)

welcome_df = df.withColumn("process_date", df['process_date_temp'].cast('date')).drop('process_date_temp')
print("GCS Storage DF Start here ")
welcome_df.printSchema()
welcome_df.show(10)
print("GCS Storage DF End here ")



target_table = 'iwinner-data-309713.staging.employee_tbl_partition'

#sql=""" SELECT * FROM `iwinner-data-309713.staging.employee_tbl_partition` WHERE process_date = '2021-01-01' """
bigquery_sql = spark.read.format("bigquery").option('table',target_table).option('filter',"process_date = '2021-01-01'").load()
#bigquery_sql = spark.read.format('bigquery').option('table', target_table).option('filter', "_PARTITIONTIME = '2021-01-01'")).load()
print("bigquery_sql start here")
bigquery_sql.printSchema()
bigquery_sql.show()
print("bigquery_sql End here")

hive_df=spark.sql("select * from iwinner_db.emp_tbl")
print("hive_df start here")
hive_df.printSchema();
hive_df.show(10)
print("hive_df End here")