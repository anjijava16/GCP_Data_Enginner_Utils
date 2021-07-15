Getting Started With Git clone
===================================
1. cd desktop
2. git clone 
3. cd GCP_Data_Enginner_Utils



Copy Files From Local FS to GCS
---------------------------------------
gsutil cp input.csv gs://$BUCKET_NAME/
gsutil cp spark_job.py gs://$BUCKET_NAME/


How to Run the Pyspark job as Dataproc API
----------------------------------------------
### PySpark Job :
gcloud dataproc jobs submit pyspark \
    gs://BUCKET_NAME/spark_job.py \
    --cluster=cluster-e350  \
    --region=us-central1 



