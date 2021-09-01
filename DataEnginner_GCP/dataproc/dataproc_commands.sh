

gcloud compute ssh ${HOSTNAME} \
    --project=${PROJECT} --zone=${ZONE}  -- \
    -D ${PORT} -N


gcloud compute ssh ${HOSTNAME} --project=${PROJECT} --zone=${ZONE}  ---D ${PORT} -N

## Connect dataproc cluster :

gcloud compute ssh cluster-b752-m --zone=us-central1-c


gcloud dataproc clusters create basil \
   --region us-central1 \
    --zone us-central1-a \
    --master-machine-type n1-standard-1 \
    --master-boot-disk-size 30 \
    --num-workers 2 \
    --worker-machine-type n1-standard-1 \
    --worker-boot-disk-size 30 \
    --project iwinner-data


gcloud dataproc clusters create \
   --num-workers=2 \
   --worker-machine-type=n1-standard-1 \
   --master-machine-type=n1-standard-1 \
   --image-version=1.3-ubuntu18 \
   --enable-component-gateway \
   --optional-components=ANACONDA,JUPYTER \
   --zone=us-central1-a \
   --region=us-central1 \
   cluster1

gcloud beta dataproc clusters create cluster-fb01 \
       --region us-central1 \
	   --zone us-central1-c \
	   --master-machine-type n1-standard-4 \
	   --master-boot-disk-size 200 \
	   --num-workers 2 \
	   --worker-machine-type n1-standard-4 \
	   --worker-boot-disk-size 200 \
	   --image-version 2.0-debian10 \
	   --optional-components ANACONDA,HIVE_WEBHCAT,ZOOKEEPER,HBASE,DOCKER \
	   --project iwinner-data

###########
gcloud dataproc clusters create ${CLUSTER_NAME}
       --region=${CLUSTER_REGION}
       --scopes=default,sql-admin
       --initialization-actions=gs://dataproc-initialization-actions/cloud-sql-proxy/cloud-sql-proxy.sh
       --properties=hive:hive.metastore.warehouse.dir=gs://$GCS_BUCKET/export
       --metadata=enable-cloud-sql-hive-metastore=false
       --metadata=additional-cloud-sql-instances=${PSQL_INSTANCE}=tcp:${PSQL_PORT}
###########


gcloud beta dataproc clusters create cluster-fb01 --region us-central1 --zone us-central1-c --master-machine-type n1-standard-4 --master-boot-disk-size 500 --num-workers 2 --worker-machine-type n1-standard-4 --worker-boot-disk-size 500 --image-version 2.0-debian10 --optional-components ANACONDA,HIVE_WEBHCAT,ZOOKEEPER,HBASE,DOCKER --project iwinner-data


cluster-fb01



gcloud compute ssh cluster-fb01-m --zone=us-central1-c


https://codelabs.developers.google.com/codelabs/cloud-dataproc-gcloud#3


export PROJECT=iwinner-data;
export HOSTNAME=cluster-fb01-m;
export ZONE=us-central1-c
export PORT=1080
gcloud compute ssh ${HOSTNAME} \
    --project=${PROJECT} --zone=${ZONE}  -- \
    -D ${PORT} -N




## Dataproc Connection
gcloud compute ssh cluster-e350-m --zone=us-central1-f



######### Hive Jobs
gcloud dataproc jobs submit hive --cluster=cluster-e350 --region us-central1 -f create_tables.hql
               (OR)
gcloud dataproc jobs submit hive --cluster=cluster-e350 --region us-central1 -f gs://iwinner-dataproc/hive/create_tables.hql
               (OR)


gcloud dataproc jobs submit hive \
    --cluster cluster-e350 \
    --region us-central1 \
    --execute " create table iwinner_db.welcome(id int,name string) "


#### Hive External table creation :
gcloud dataproc jobs submit hive \
    --cluster cluster-e350 \
    --region us-central1 \
    --execute "
      CREATE EXTERNAL TABLE transactions
      (SubmissionDate DATE, TransactionAmount DOUBLE, TransactionType STRING)
      STORED AS PARQUET
      LOCATION 'gs://$PROJECT-warehouse/datasets/transactions';"

## Hive Select query
gcloud dataproc jobs submit hive \
    --cluster cluster-e350 \
    --region us-central1
    --execute "
      SELECT *
      FROM transactions
      LIMIT 10;"

create_tables.hql:

use iwinner_db;
CREATE TABLE inventory_fact
(product_id INT,
time_id INT,
warehouse_id INT,
store_id INT,
units_ordered INT,
units_shipped INT,
warehouse_sales DOUBLE,
warehouse_cost DOUBLE,
supply_time INT,
store_invoice DOUBLE
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES("skip.header.line.count"="1");



gcloud dataproc jobs submit hive \
    --cluster hive-cluster \
    --region ${REGION} \
    --execute "
      CREATE EXTERNAL TABLE transactions
      (SubmissionDate DATE, TransactionAmount DOUBLE, TransactionType STRING)
      STORED AS PARQUET
      LOCATION 'gs://${PROJECT}-warehouse/datasets/transactions';"

##################Spark Job

gsutil cat gs://dataproc-examples/pyspark/hello-world/hello-world.py

## PySpark Job :
gcloud dataproc jobs submit pyspark \
    gs://dataproc-examples/pyspark/hello-world/hello-world.py \
    --cluster=cluster-e350  \
    --region=us-central1

## Spark Scala or Java Jobs :
gcloud dataproc jobs submit spark \
    --cluster=cluster-e350  \
    --region=us-central1 \
    --class=org.apache.spark.examples.SparkPi \
    --jars=gs://iwinner-dataproc/spark/spark-examples_2.11-2.4.5.jar \
    -- 1000

##Jobs urls:
http://cluster-e350-m:8088/cluster

http://cluster-e350-m:8088/proxy/application_1614738222683_0005/

YARN ResourceManager	80881	http://master-host-name:8088
HDFS NameNode	98702,3	http://master-host-name:9870
http://cluster-e350-m:9870/



gcloud dataproc jobs submit spark --cluster=my_cluster  --region=us-central1 --jar=my_jar.jar -- arg1 arg2

gcloud dataproc jobs submit pyspark --cluster=my_cluster  file:///usr/lib/spark/examples/src/main/python/pi.py 100



########################## Pig Jobs running as dataproc

#To submit a Pig job with a local script, run:
gcloud dataproc jobs submit pig --cluster=my_cluster  --file=my_queries.pig


# To submit a Pig job with inline queries, run:
gcloud dataproc jobs submit pig --cluster=my_cluster
    -e="LNS = LOAD 'gs://my_bucket/my_file.txt' AS (line)"
    -e="WORDS = FOREACH LNS GENERATE FLATTEN(TOKENIZE(line)) AS word"
    -e="GROUPS = GROUP WORDS BY word"
    -e="WORD_COUNTS = FOREACH GROUPS GENERATE group, COUNT(WORDS)"
    -e="DUMP WORD_COUNTS"

####### SQOOP Jobs

gsutil mb -l europe-west4 gs://my-oracle-extract
JAR_BUCKET=gs://my-sqoop-jar-bucket
STAGING_BUCKET=gs://my-oracle-extract
libs=`gsutil ls $JAR_BUCKET | paste -sd, — `
JDBC_STR=jdbc:oracle:thin:<username>/<password>@<IP>:1521/<SERVICE>
TABLE=EMPLOYEES
SCHEMA=HR
gcloud dataproc jobs submit hadoop — cluster=sqoop-cluster — region=europe-west4 — class=org.apache.sqoop.Sqoop — jars=$libs — import -Dmapreduce.job.user.classpath.first=true -Dorg.apache.sqoop.splitter.allow_text_splitter=true — connect=$JDBC_STR — target-dir=$STAGING_BUCKET/$TABLE — table=$SCHEMA.$TABLE — enclosed-by ‘\”’ — escaped-by \” — fields-terminated-by ‘|’ — null-string ‘’ — null-non-string ‘’ — as-textfile

bucket="gs://airflow12"

pwd_file=$bucket/passwords/password.txt

table_name="sales"

target_dir=$bucket/sqoop_output

# Simple table import - Text Format :

gcloud dataproc jobs submit hadoop \
--cluster=$1 --region=us-central1 \
--class=org.apache.sqoop.Sqoop \
--jars=$bucket/sqoop_jars/sqoop_sqoop-1.4.7.jar,$bucket/sqoop_jars/sqoop_avro-tools-1.8.2.jar,file:///usr/share/java/mysql-connector-java-5.1.42.jar \
-- import \
-Dmapreduce.job.user.classpath.first=true \
-Dmapreduce.output.basename="sales" \
--driver com.mysql.jdbc.Driver \
--connect="jdbc:mysql://localhost:3307/Sales" \
--username=root --password-file=$pwd_file\
--split-by id \
--table $table_name \
-m 4 \
--target-dir $target_dir \
--as-avrodatafile

gcloud dataproc jobs submit hadoop \
    --bucket=gs://rodbigdatabucket \
    --cluster=rodsbigdata \
    --class=org.apache.sqoop.Sqoop \
    --jars=gs://rodbigdatabucket/jars/sqoop-1.4.7-hadoop260.jar,gs://rodbigdatabucket/jars/avro-tools-1.8.2.jar,file:///usr/share/java/mysql-connector-java-5.1.42.jar \
    --properties=mapreduce.job.user.classpath.first=true,mapreduce.job.classloader=true \
    -- \
    import \
    --connect=jdbc:mysql://localhost:3307/road_safety_data \
    --username rodmartin --target-dir=gs://rodbigdatabucket/mysql_output \
    --table road_safety_data \
    --hive-import \
    --hive-overwrite \
    --target-dir gs://rodbigdatabucket/hivedata
