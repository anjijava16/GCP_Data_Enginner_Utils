# pyspark submit:
gcloud dataproc jobs submit pyspark --cluster cluster-d550  --region us-central1    --jars gs://spark-lib/bigquery/spark-bigquery-latest_2.12.jar  gs://iwinner-data/pyspark/read_file_write_bigquery.py
