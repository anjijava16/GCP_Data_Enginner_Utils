from __future__ import print_function
import tempfile
from pyspark.sql import SparkSession
from pyspark.sql import functions as F
from pyspark.sql.functions import col
from pyspark.sql.functions import *
from pyspark.sql.types import StringType,BooleanType,DateType
from pyspark.sql.types import DateType
from pyspark.sql.types import StructType,StructField, StringType, IntegerType

print("Start the Spark Job ")
spark = SparkSession.builder.appName('spark_job_logs_data_IAC_POC').enableHiveSupport().getOrCreate()

INPUT_PATH='gs://iwinner-data/data/input/'
OUTPUT_PATH='gs://iwinner-data/data/output'

schema = StructType([ \
    StructField("Country",StringType(),True), \
    StructField("Age",IntegerType(),True), \
    StructField("Salary",IntegerType(),True), \
    StructField("Purchased", StringType(), True), \
    StructField("ts", StringType(), True) ])

print("Schema Info: "+schema)

print("Input File Path :"+INPUT_PATH)

input_df = spark.read.format("csv") \
      .option("header", True) \
      .schema(schema) \
      .load(INPUT_PATH)
print("OUTPUT_PATH: "+OUTPUT_PATH)

print("Display the input data frame schema ")
input_df.printSchema()

print("Display the input data 20 records")
input_df.show(10,False)


print("Write dataframe to parquet files")
input_df.write.format("parquet").mode('overwrite').save(OUTPUT_PATH)

print("END the Spark Job")
