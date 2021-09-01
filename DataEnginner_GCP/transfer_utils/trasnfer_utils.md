# 1 GCS Trasnfer 
i. GCS Trasnfer Tools (For small trasnfers upto a few TB'S)
  GSUTIL
  rsync --Fast multi thread mode 


# 2 Trasnfer service 
ii. Trasnfer service 
   Tools: UI,Client Libraries,HTTP REST API
   
###   Transfer Service for cloud data : 
   Transfer Service enables you to quickly and securely transfer data into Google Cloud Storage from a variety of online sources, such as Amazon S3 and Azure Blob Storage, or to move data between Cloud Storage buckets.
   
###   Transfer Service for on-premises data :
   Transfer Service for on-premises data lets you quickly and securely move your data from private data centers into Google Cloud Storage. To get started, connect to your data center by installing an agent and then create a transfer job.
    An agent is a lightweight application that enables Transfer Service users to transfer data from filesystems (ex. on-premises filers). 
	Learn more The agent runs inside a Docker container, which allows Transfer Service to update the agent on your behalf.
    You’ll need at least one agent per project; as you install more, your project’s transfer workload is distributed equally across the agents. 
    Steps:
	    i.   Create Pub/Sub resources (once per project) 
		ii.  Install Docker
		iii. Start the agent
		iv.  Set up alerting
		v.   Documentation 

# 3. Trasnfer Appliance

   Large scale trasnfers from low bandwidth network
    Requeset appliance ---> Upload data SFTP,SCP or NFS ---> ship to Google ---> GCS--> Erase NIST 800 Standard
   1 PB data (40 days)
   Phsical boxes


# 4 . Bigquery Data Trasnfer (using mirror-agent.jar file)
      SAAS
      Data from SAAS & 3rd Party apps
     S3,Teradata,Redshift ---> SAAS ---> Google Saas apps,GCS,3rd party
    At a high level, the process of migrating a data warehouse involves four stages:
	■■ Assessing the current state of the data warehouse
	■■ Designing the future state
	■■ Migrating data, jobs, and access controls to the cloud
	■■ Validating the cloud data warehouse
