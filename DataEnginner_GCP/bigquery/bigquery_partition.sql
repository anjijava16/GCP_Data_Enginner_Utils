https://github.com/GoogleCloudDataproc/spark-bigquery-connector/blob/master/connector/src/main/java/com/google/cloud/spark/bigquery/SparkBigQueryConfig.java

https://www.gitmemory.com/issue/GoogleCloudDataproc/spark-bigquery-connector/308/779598026


https://chartio.com/resources/tutorials/bigquery-vs-athena/

Caused by: com.google.cloud.spark.bigquery.repackaged.com.google.cloud.bigquery.BigQueryException: Incompatible table partitioning specification. Expects partitioning specification interval(type:day,field:process_date) clustering(id), but input partitioning specification is interval(type:day,field:DAY)



df.write.format(dataSourceFormat)
        .option("table", fullTableNamePartitioned)
        .option("temporaryGcsBucket", temporaryGcsBucket)
        .option("partitionField", "created_timestamp")
        .option("clusteredFields", "platform")
        .mode(SaveMode.Overwrite)
        .save()
		

df.write.format("bigquery")
      .option("temporaryGcsBucket", temporaryGcsBucket)
      .option("partitionField", "t")
      .option("partitionType", partitionType)
      .option("partitionRequireFilter", "true")
      .option("table", table)
      .save()
	  
newDataDF.write.format(dataSourceFormat)
        .option("temporaryGcsBucket", temporaryGcsBucket)
        .option("datePartition", "20200701")
        .mode("overwrite")
        .save(fullTableName)
