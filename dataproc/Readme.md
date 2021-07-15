Getting Started With Git clone
===================================
1. cd desktop
2. git clone https://github.com/anjijava16/GCP_Data_Enginner_Utils.git
3. cd GCP_Data_Enginner_Utils/dataproc



Copy Files From Local FS to GCS
---------------------------------------
1.  gsutil cp input.csv gs://$BUCKET_NAME/
2.  gsutil cp spark_job.py gs://$BUCKET_NAME/


How to Run the Pyspark job as Dataproc API
----------------------------------------------
### PySpark Job :
gcloud dataproc jobs submit pyspark  gs://BUCKET_NAME/spark_job.py --cluster=cluster-e350 --region=us-central1 

### Note in the above pyspark change cluser name and region (based on the dataproc cluster creation)


