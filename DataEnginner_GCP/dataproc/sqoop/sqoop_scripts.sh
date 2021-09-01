export MYSQL_JAR="gs://welcome-iwinner-bqload/jars/mysql-connector-java-5.1.37.jar"
export SQOOP_JAR="gs://welcome-iwinner-bqload/jars/sqoop-1.4.7.jar"
export AVRO_JAR="gs://welcome-iwinner-bqload/jars/avro-1.8.2.jar"
                 
export GCS_BUCKET="welcome-iwinner-bqload/output/"
export CLUSTER_NAME="cluster-fa77 "
export CLUSTER_REGION="us-central1"
export CONNECTION_STRING="jdbc:mysql://103.120.176.33:3306/mmtechso_reportdb"
export SOURCE_USER="welcome"
export SOURCE_PASSWORD="bu3anyper"



gcloud dataproc jobs submit hadoop \
       --cluster=${CLUSTER_NAME}  \
       --class=org.apache.sqoop.Sqoop \
       --jars=${MYSQL_JAR},${SQOOP_JAR},${AVRO_JAR} \
       --region=$CLUSTER_REGION \
       -- import -Dmapreduce.job.user.classpath.first=true \
	   --driver com.mysql.jdbc.Driver \
       --connect="${CONNECTION_STRING}" \
       --username=${SOURCE_USER} \
       --password="${SOURCE_PASSWORD}" \
       --target-dir=gs://$GCS_BUCKET/5441 \
       --table=orders


# Parquet Issue 

export MYSQL_JAR="gs://welcome-iwinner-bqload/jars/mysql-connector-java-5.1.37.jar"
export SQOOP_JAR="gs://welcome-iwinner-bqload/jars/sqoop-1.4.7.jar"
export AVRO_JAR="gs://welcome-iwinner-bqload/jars/avro-1.8.2.jar"
                 
export GCS_BUCKET="welcome-iwinner-bqload/output/"
export CLUSTER_NAME="cluster-fa77 "
export CLUSTER_REGION="us-central1"
export CONNECTION_STRING="jdbc:mysql://103.120.176.33:3306/mmtechso_reportdb"
export SOURCE_USER="xxxx"
export SOURCE_PASSWORD="ccccc"



gcloud dataproc jobs submit hadoop \
       --cluster=${CLUSTER_NAME}  \
       --class=org.apache.sqoop.Sqoop \
       --jars=${MYSQL_JAR},${SQOOP_JAR},${AVRO_JAR} \
       --region=$CLUSTER_REGION \
       -- import -Dmapreduce.job.user.classpath.first=true \
	   --driver com.mysql.jdbc.Driver \
       --connect="${CONNECTION_STRING}" \
       --username=${SOURCE_USER} \
       --password="${SOURCE_PASSWORD}" \
	   --delete-target-dir \
       --target-dir=gs://$GCS_BUCKET/5441 \
       --table=orders \
	   --as-parquetfile 
