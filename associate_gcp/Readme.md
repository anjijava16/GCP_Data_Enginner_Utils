
Three Core Componenets:
----------------------------------
  1. Network: Moving
  2. Compute: Processing
  3. Storage: Rembeber


The Associate Cloud Engineer exam assesses your ability to:
-----------------------------------------------------------
1. Set up a cloud solution environment
2. Plan and configure a cloud solution
3. Deploy and implement a cloud solution
4. Ensure successful operation of a cloud solution
5. Configure access and security


Associate Cloud Enginner:
---------------------------------------
1. Setting up a cloud solution environment:20%
2. Planning and configuring a cloud solution:20%
3. Deploying and implementing a cloud solution:20%
4. Ensuring successful operation of a cloud solution:20%
5. Configuring access and security:20%


Resource Hierachy
IAM 
Application Programming Interfaces
Stackdriver workspace
Billing

CommandLine Interface(CLI) Knowledge



Resource Hierachy:
		Organization
	Fold1    Fold2
Projec1  Project2   Project3  Project4 


IAML
Who need what Access and Which resources



Compute Options
--------------------------
1.	Google Compute Engine (GCE): Monthalic
2.  Google Kubernates Engine (GKE): MicroService
3.  Google App Engine (GAE): No depdency on Infrastrcture
4.  Google Cloud Functions: Simple single Server 
     (Highly customizable/ Highly Managed)
 


GCP Cloud Storage
---------------------------------------------
1. Object:
    Cloud Storage (4 Types of storage)
2. Relational:
   Cloud SQL: TB of data 
   Cloud Spanner : Horinztal scaling(PB Data)

3. Non-Relational:
    CloudFirestore: Document based data 
    Cloud BigTable:Wide columns of data 

4. WareHouse:
   Cloud BigQuery:Query on data simple data 

For Mobile SDK'S:
   Firebase   
 

Networking Product in GCP :
--------------------------------------------------
1. Connect: (on Premise to GCP Connection throgh secure channel)
	  
    	  1. VPC: 
	      2. Cloud DNS
	      3. Cloud VPN 
	      4. Cloud InterConnect

2. Scale:
      1. Cloud Load Balancing
      2.  Cloud CDN

3. Optimize
       1.  Standard Network Tier
       2.  Premium Network Tier 

4. Secure
    1.  Cloud Armor
    2.  IAP
    3.  Cloud NAT 	
   
Deploying and implementing a Cloud Solution:
-----------------------------------------------------------------
1. Deploying and implemnting Compute Engine resources
2. Deploying and implemnting GKE resources   
3. Deploying and implemnting App Engine,Cloud Run and Cloud Functions resources   




Github Links:
------------------------------
1. https://github.com/ACloudGuru/gcp-cloud-engineer.git
2. https://github.com/ACloudGuru-Resources
3. https://github.com/linuxacademy/content-gc-essentials
4. https://github.com/ACloudGuru-Resources/training-data-analyst.git    


Global System :
-----------------------------------------
GCP is intrinsically global

AWS is intrinsically region-scoped 

Regional Model
   Simplifies data sovereignty

Global Model 
   Easier to handle latency and failures in a global way
   Could be more sensitive to multi region/ global failure modes


Phsical Infrastucture:
---------------------------------
  * vCPU   
  * Physical server
  * Rack
  * Data Center(building)
  * Region 
  * Multi-Region
  * Zone 
  * Private Global Network 
  * Points of Presence(POPS)-Network edges and CDN locations 
  * GLobal Systems 
  
 Network Ingress(Input) & Egress(output):
--------------------------------------------
  Single global IP address can load balance worldwide
  Network Encryption:
    All Control info encrypted
    All WAN traffic to be encrypted automatically
    Moving towards enrypting all local traffic within data centers
  Distrust the network ,anyway
     BeyondCorp

Queryable
gcloud compute project-info describe --project iwinner-data


Projects <<===>> ACCOUNTS
Projects own resourcess 
Resources can be shared with other projects
Projects can be grouped and controlled in a hierarchy 
	 
	Role: Billing Account User 
	Purpose: Link Project to billing accounts
	Level:Organization or billing accounts
	UseCase: This role has very restricted permissions
	
	
Node js  start:
-------------------------------	
	node hello.js
	nodemon html-hello.js 
	
	
Mental Models:
----------------------------------
* A simplified represenation of reality ,which is...


Cloud Shell Lab data Flow:
------------------------------
	 
 
