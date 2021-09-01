from __future__ import print_function
import tempfile
from pyspark.sql import SparkSession
from pyspark.sql import functions as F
from pyspark.sql.functions import col
from pyspark.sql.functions import *
from pyspark.sql.types import StringType,BooleanType,DateType
from pyspark.sql.types import DateType


spark = SparkSession.builder.appName('covid19_jhu').getOrCreate()
df = spark.read.option("header","true").csv('gs://iwinner-data/data/bq_input/input.csv')
welcome_df = df.withColumn("process_date", df['process_date_temp'].cast('date')).drop('process_date_temp')
welcome_df.printSchema()
welcome_df.show(10)
#.option("datePartition", "YYYYMMDD") \ .option('partitionType', 'DAY') \ .option('partitionType', 'DAY') \ .option('partitionType', '_PARTITIONDATE') \
target_table = 'iwinner-data-309713.staging.employee_tbl_partition'
#df = spark.read.format('bigquery').load(table)
# iwinner-data-temp
# welcome_df.write \
#     .format("bigquery") \
#     .option("temporaryGcsBucket", "iwinner-data-temp") \
#     .option('partitionType', 'DAY') \
#     .option('partitionField', "process_date") \
#     .option('clusteredFields',"id") \
#     .mode('overwrite').save(target_table)
# date='20210101'
# welcome_df.write \
#     .format("bigquery") \
#     .option("temporaryGcsBucket", "iwinner-data-temp") \
#     .option("datePartition", date) \
#     .option('partitionType', 'DAY') \
#     .option('partitionField', "process_date") \
#     .option('clusteredFields',"id") \
#      .mode("overwrite") \
#     .save(target_table)


date='20240101'
welcome_df.write \
    .format("bigquery") \
    .option("temporaryGcsBucket", "iwinner-data-temp") \
    .option("datePartition", date) \
    .mode("overwrite") \
    .save(target_table)
