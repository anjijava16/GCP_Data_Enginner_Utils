# Copy Hive Table to Bigquery 

# Connect HIVE CLI 
1. set hive.ddl.output.format=json
2. desc extended sales_info_ORC

# Create BQ DDL 
1. DDL Creation 
# Copy Data From Hive HDFS Path to BQ Load Using BQ Load
1. Using Distcp Copy 

# Validate data into the BQ UI
bq show $DATASET.$TABLENAME



Step1: (GCS Setup connection, script pre validation)
    Pre Validation

Step2: Object Validation 
   Hive and BQ Source and Target Object validation
   
Step3: Metadata Generation Logic (Java_Spring OR Java OR Python)

Step4: Copy MapRFS to GCS Copy using Distcp

Step5: Create temp table in BQ using metadata generation scripts (DDL)

Step6: Create external table in Hive using Dataproc Hive CLI jobs

Step7: msck repair table HIVE CLI because data copied just now using Step 4

Step8: Check Data Load into the BQ External tables

Ste9: Use here BQ Insert query from Stage to Target copy (Generated Metadata Logic)

Step10: Count Query from Hive and BQ (Not good think some alernative solution)

Step11: Post Validation write into File

Step12: Copy Done file data to BQ table for Reporting and audit purpose 



# Reference Links
1. https://www.youtube.com/watch?v=l5I0knEcH4I
2. https://cloud.google.com/bigquery/docs/hive-partitioned-queries-gcs#bq







