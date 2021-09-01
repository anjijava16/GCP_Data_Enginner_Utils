Reference Links:
-----------------------------------------
0. https://cloud.google.com/free
1. Architecture:  https://gcp.solutions/ 
2. AWS VS GCP (For AWS Developer to GCP) : https://cloud.google.com/docs/compare/aws
3. https://cloud.google.com/certification/guides/professional-cloud-architect
4. Docs:  https://cloud.google.com/docs
5. Tutorials: https://cloud.google.com/docs/tutorials

Labs:
-------------------------------
1. https://console.cloud.google.com/?pli=1
1. https://google.qwiklabs.com/users/sign_in
2. https://github.com/georgezoto/Google-Cloud-Platform-Associate-Cloud-Engineer


IMP LINKS/ Github Link:
------------------------------------
 1. https://github.com/sathishvj/awesome-gcp-certifications
 2. https://github.com/gregsramblings/google-cloud-4-words
 3. https://github.com/Ulminator/gcp-certification-notes
 4. https://github.com/priyankavergadia/GCPSketchnote
 5. https://thecloudgirl.dev/
 6. https://github.com/GoogleCloudPlatform/training-data-analyst
 7. https://github.com/GoogleCloudPlatform/training-data-analyst/tree/master/courses/data-engineering/demos
 7. https://github.com/GoogleCloudDataproc/spark-bigquery-connector
 7. https://github.com/GoogleCloudPlatform/training-data-analyst/tree/master/courses
 7. https://github.com/gregsramblings/google-cloud-4-words
 7. https://github.com/GoogleCloudPlatform/bigquery-oreilly-book/tree/master/02_query
 7. https://github.com/PacktPublishing/Learning-Google-BigQuery
 7. https://github.com/PacktPublishing/Machine-Learning-with-BigQuery-ML/blob/master/Chapter03/bigquery_syntax.sql
 7. https://github.com/GoogleCloudDataproc/initialization-actions
 7. https://github.com/GoogleCloudDataproc/spark-bigquery-connector/tree/master/examples/notebooks
 7. https://github.com/GoogleCloudDataproc/cloud-dataproc/tree/master/notebooks/python
 
Udemy Courses :
-----------------------------------------------
1. Cloug Enginner :     https://www.udemy.com/course/google-certified-associate-cloud-engineer/
1. Cloud Data Enginner: https://www.udemy.com/course/gcp-data-engineer-and-cloud-architect/learn/lecture/7599964#overview



Books:
----------------
1. Google BigQuery: The Definitive Guide
2. Official Google Cloud Certified Professional Data Engineer Study Guide (Dan Sullivan)



Google Certificates:
----------------------------------------
1. Associate Cloud Engineer (General for every one) (Fee: $125 & 2 hours)
2. Professional
   1.	cloud-architect
     2. Cloud Developer
     3. Data Engineer
     4. Cloud DevOps Engineer
     5. Machine Learning Enginee
     6. Cloud Network Engineer
     7. Cloud Security Engineer
     8. Collaboration Engineer
		 
Install:
--------------------------
1.	GoogleCloudSDKInstaller (GcloudSDK.exe)
2.  gcloud commands for the gcloud tool, Google Cloud’s primary command-line tool.
3.  bq  https:/
4.  gsutil: gsutil is the command-line Google Storage utilities. Equivalent to aws s3 but for the Google Cloud Platform, it allows you to access Google Cloud Storage from the command line.


vi ~/.bashrc

export PATH=/home/ec2-user/google-cloud-sdk/bin:$PATH

source ~/.bashrc

export SERVICE_ACCOUNT=iwinner-data-service-account@iwinner-data.iam.gserviceaccount.com
export GOOGLE_APPLICATION_CREDENTIALS=/home/ec2-user/iwinner-data.json
export PROJECT_ID=iwinner-data
gcloud config set account $SERVICE_ACCOUNT
gcloud auth activate-service-account $SERVICE_ACCOUNT --key-file=$GOOGLE_APPLICATION_CREDENTIALS --project=$PROJECT_ID

Compute Services:
-----------------------------
Where can you run your applications in GCP?
I will present 4 places where your code can run in GCP:
1. Google Compute Engine
2. Google Kubernetes Engine
3. App Engine
4. Cloud Functions



Commands:
------------------------
1. gsutil help
2. gcloud help 
3. bq help 
4. cbt help (For BigTable)
5. datalab (For ML & Jupter notebooks)


Create Google Service Account credentials.
-------------------------------------
	1. Go to IAM & admin -> Service accounts.
	2. Click CREATE SERVICE ACCOUNT.
	3. Enter a Service account name and Service account description.
	4. Click CREATE.
	5. In the next screen Service account permissions , select a role.
	6. Select Storage -> Storage Admin.
	7. Click CONTINUE. & Click Create key.
gcloud auth activate-service-account iwinner-data-service-account@iwinner-data.iam.gserviceaccount.com --key-file=test_google_account.json	
