Data:
Data.csv 
Country,Age,Salary,Purchased,ts
France,44,7200,NO,2021-07-02 17:06:19
Spain,27,4800,Yes,2020-07-02 17:06:19
Germany,30,5400,NO,2019-07-02 17:06:19
France,38,6100,NO,2021-06-02 17:06:19
Spain,40,7200,NO,2021-07-04 17:06:19
Germany,35,7200,NO,2018-07-02 17:06:19
France,,7200,NO,2017-07-02 17:06:19
Spain,48,7200,NO,2016-07-02 17:06:19
Germany,50,7200,Yes,2015-07-02 17:06:19



import org.apache.spark.sql.types._

val customSchema = StructType(Array(
  StructField("country", StringType, true),
  StructField("age", IntegerType, true),
  StructField("salary", IntegerType, true),
  StructField("purchased", StringType, true),
  StructField("ts", TimestampType, true))
)

val df=spark.read.format("csv").option("header", "true").option("inferSchema", "true").schema(customSchema).load("C:/data/Data.csv")

df.write.format("parquet").option("mode","append").save("C:/data/welcome_string/data")

val df2=spark.read.format("parquet").load("C:/data/parquet/data") 




## HDFS to GCS Load 
gsutil -m cp C:/data/parquet/data/*.parquet gs://welcome_dts/data/

## Check objects in GCS bucket 
gsutil ls gs://welcome_dts/data/
#BQ Table :
create table welcome.data_welcome(
country string,
age int64,
salary int64,
purchased string
ts Datetime)

bq load --source_format=PARQUET welcome.data_welcome gs://welcome_dts/data/*.parquet

	

## Change column location 
df.createOrReplaceTempView("temp")
 val df3=spark.sql("select country as country, salary,age,purchased from temp")
 df3.write.format("parquet").option("mode","overwrite").save("C:/data/parquet/data")
 
 val df4=spark.read.format("parquet").load("C:/data/parquet/data2")
 
 C:/data/parquet/data2
 
 gsutil -m cp C:/data/parquet/data2/*.parquet gs://welcome_dts/data2/
 
 bq load --replace --source_format=PARQUET welcome.welcome_test gs://dev-iwinner-data-july04/data/*.parquet
 
 bq load --replace --source_format=PARQUET welcome.welcome_test gs://dev-iwinner-data-july04/data/*.parquet

