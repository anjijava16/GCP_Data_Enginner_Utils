https://stackoverflow.com/questions/36948440/converting-pipe-delimited-file-to-spark-dataframe-to-csv-file

https://stackoverflow.com/questions/41268182/how-to-use-double-pipe-as-delimiter-in-csv


James,Butt,"Benton, John B Jr",6649 N Blue Gum St
Josephine,Darakjy,"Chanay, Jeffrey A Esq",4 B Blue Ridge Blvd
Art,Venere,"Chemel, James L Cpa",8 W Cerritos Ave #54
Lenna,Paprocki,Feltz Printing Service,639 Main St,Anchorage
Donette,Foller,Printing Dimensions,34 Center St,Hamilton
Simona,Morasca,"Chapman, Ross E Esq",3 Mcauley Dr 



https://forums.databricks.com/questions/44952/spark-read-csv-doesnt-preserve-the-double-quotes-w.html



+----------+---------+-------------------------+---------------------+
|first_name|last_name|company_name             |address              |
+----------+---------+-------------------------+---------------------+
|James     |Butt     |"Benton                  | John B Jr"          |
|Josephine |Darakjy  |"Chanay                  | Jeffrey A Esq"      |
|Art       |Venere   |"Chemel                  | James L Cpa"        |
|Lenna     |Paprocki |Feltz Printing Service   |639 Main St          |
|Donette   |Foller   |Printing Dimensions      |34 Center St         |
|Simona    |Morasca  |"Chapman                 | Ross E Esq"         |
+----------+---------+-------------------------+---------------------+

https://forums.databricks.com/questions/12237/handle-comma-inside-cell-of-csv.html


val text = sc.textFile("fruit.csv")
val word = text.map( l => l.split("\\|\\|")
val last = word.map( w => w(w.size - 1))
last.distinct.collect

https://forums.databricks.com/questions/44952/spark-read-csv-doesnt-preserve-the-double-quotes-w.html


id,name,bob,bob_str
10,mm,0001-01-01,0001-01-01
11,bb,0001-01-01,0001-01-01
12,cc,0001-01-01,0001-01-01
14,dd,0001-01-01,0001-01-01


CREATE TABLE welcome.bq_welcome (
  id INT64,
  name string,
  bob DATE,
  bob_str string
 
)

    bq load \
    --source_format=CSV \
    welcome.bq_welcome \
   /home/mamathamams39/welcome.csv \
    qtr:STRING,sales:FLOAT,year:STRING
	
	
from pyspark.sql import SparkSession
spark = SparkSession.builder.appName('Shakespeare WordCount').getOrCreate()
df = spark.read.format("bigquery").load("welcome.bq_welcome")
df.printSchema()
df.show(10)

gsutil cp *.py gs://dev-iwinner-data-july04/

us-central1

gcloud dataproc jobs submit pyspark --cluster "cluster-16ce" --region "us-central1"\
  --jars gs://spark-lib/bigquery/spark-bigquery-latest_2.12.jar \
  gs://dev-iwinner-data-july04/spark-bigquery.py




mamathamams39@cloudshell:~ (iwinner-data-318822)$ gcloud dataproc jobs submit pyspark --cluster "cluster-16ce" --region "us-central1"\
>   --jars gs://spark-lib/bigquery/spark-bigquery-latest_2.12.jar \
>   gs://dev-iwinner-data-july04/spark-bigquery.py

PrintSchema():
 |-- id: long (nullable = true)
 |-- name: string (nullable = true)
 |-- bob: date (nullable = true)
 |-- bob_str: string (nullable = true)

show():
+---+----+----------+----------+
| id|name|       bob|   bob_str|
+---+----+----------+----------+
| 10|  mm|0001-01-01|0001-01-01|
| 11|  bb|0001-01-01|0001-01-01|
| 12|  cc|0001-01-01|0001-01-01|
| 14|  dd|0001-01-01|0001-01-01|
+---+----+----------+----------+




cluster-641d

gcloud dataproc jobs submit pyspark --cluster "cluster-641d" --region "us-central1"\
  --jars gs://spark-lib/bigquery/spark-bigquery-latest_2.12.jar \
  gs://dev-iwinner-data-july04/spark-bigquery.py
  
  
  
gcloud dataproc jobs submit pyspark --cluster "cluster-641d" --region "us-central1"\
  --jars gs://spark-lib/bigquery/spark-bigquery-latest_2.11.jar \
  gs://dev-iwinner-data-july04/spark-bigquery.py
  
  
