

export PS1="\[\e[34m\]\w\[\e[m\]>\n-->"

gcloud pubsub subscriptions pull --auto-ack sale_day_offers_sub


gcloud pubsub subscriptions pull --auto-ack sale_day_offers_sub --limit 10




export PS1="\[\e[34m\]\w\[\e[m\]-->\n>"

gcloud pubsub topics create spikey_bugs



gcloud pubsub subscriptions create --topic spikey_bugs --ack-deadline=60  spikey_bugs_dev_sub

gcloud pubsub subscriptions create --topic spikey_bugs  --ack-deadline=60 spikey_bugs_reports_sub

gcloud pubsub topics publish spikey_bugs --message "Tester 1: Problem editing number of items in the cart."

gcloud pubsub subscriptions pull --auto-ack spikey_bugs_dev_sub

gcloud pubsub subscriptions pull --auto-ack spikey_bugs_dev_sub

gcloud pubsub subscriptions pull --auto-ack spikey_bugs_reports_sub 

gcloud pubsub subscriptions pull --auto-ack spikey_bugs_reports_sub 

gcloud pubsub topics publish spikey_bugs --message "Tester 2: Citibank - Wrong URL of the payment gateway."

gcloud pubsub topics publish spikey_bugs --message "Tester 3: Critical -  Forgot Password OTP digits ’0000’ can give access to all accounts"

gcloud pubsub topics publish spikey_bugs --message "Tester 4:  - Operation: ‘Cancel order’  logouts the user "

gcloud pubsub topics publish spikey_bugs --message "Tester 5:  - Logout from all devices doesn't logout from smart phone app "


gcloud pubsub subscriptions pull --auto-ack spikey_bugs_reports_sub --limit 10 

gcloud pubsub subscriptions pull spikey_bugs_dev_sub 

gcloud pubsub subscriptions pull --auto-ack spikey_bugs_reports_sub 

gcloud pubsub subscriptions ack spikey_bugs_dev_sub --ack-ids=XkASTD0JRElTK0MLKlgRTgQhIT4wPkVTRFAGFixdR\
khRNxkIaFEOT14jPzUgKEUSC1MTUVx1GE0QaVwzdQdRDRlze2Z0OVwTBgYUBXReURsfWVx-SgVYBRxwfmFzbVwaBAFAU1asy_7cr4MvZh\
s9XBJLLD5-NjxFQQ

gcloud pubsub subscriptions pull spikey_bugs_dev_sub 

gcloud pubsub subscriptions pull spikey_bugs_dev_sub --limit 10

gcloud pubsub subscriptions pull --auto-ack spikey_bugs_reports_sub --limit 10 

gcloud pubsub topics list

gcloud pubsub subscriptions list

gcloud pubsub topics list-subscriptions spikey_bugs

gcloud pubsub subscriptions delete spikey_bugs_dev_sub

- gcloud delete (subscription, topic)

gcloud pubsub topics list

gcloud pubsub topics delete spikey_bugs

gcloud pubsub topics list




export PS1="\[\e[34m\]\w\[\e[m\]>\n-->"

gcloud beta pubsub topics create spikey_customer_service

gcloud beta pubsub subscriptions create spikey_customer_service_sub1 --topic=spikey_customer_service --ack-deadline=10

gcloud beta pubsub topics publish spikey_customer_service --message "Issue 1: User can't login from a particular location"

gcloud beta pubsub subscriptions pull --auto-ack spikey_customer_service_sub1

gcloud beta pubsub topics publish spikey_customer_service --message 'Issue 2: Change of delivery address'



gcloud beta pubsub snapshots create customer_service_snapshot --subscription=spikey_customer_service_sub1

gcloud beta pubsub topics publish spikey_customer_service --message 'Issue 3: Cannot Edit the size of the item ordered.'

gcloud beta pubsub topics publish spikey_customer_service --message 'Issue 4: Enquiry regarding an out-of-stock item.'


gcloud beta pubsub subscriptions pull --auto-ack spikey_customer_service_sub1

gcloud beta pubsub subscriptions seek spikey_customer_service_sub1 --snapshot=customer_service_snapshot

gcloud beta pubsub subscriptions pull --auto-ack spikey_customer_service_sub1



gcloud beta pubsub subscriptions create spikey_customer_service_sub2 --topic=spikey_customer_service --ack-deadline=10

gcloud beta pubsub subscriptions pull spikey_customer_service_sub2 --auto-ack

gcloud beta pubsub snapshots delete customer_service_snapshot

- Use case for the timestamp

export PS1="\[\e[34m\]\w\[\e[m\]>\n-->"

gcloud pubsub topics list

gcloud pubsub subscriptions list

gcloud beta pubsub subscriptions update  spikey_customer_service_sub1  --retain-acked-messages

gcloud beta pubsub subscriptions pull --auto-ack spikey_customer_service_sub1

gcloud beta pubsub topics publish spikey_customer_service --message 'Issue 5: Mobile App is stuck at start Screen!'

gcloud beta pubsub subscriptions pull --auto-ack spikey_customer_service_sub1




TS_FORMAT=%Y-%m-%dT%H:%M:%SZ

gcloud beta pubsub subscriptions seek spikey_customer_service_sub1 --time=$(date -u -d '-10 min' +$TS_FORMAT)

gcloud beta pubsub subscriptions pull --auto-ack spikey_customer_service_sub1

gcloud beta pubsub topics publish spikey_customer_service --message 'Issue 6: Cannot delete an Item from the cart!'

gcloud beta pubsub topics publish spikey_customer_service --message 'Issue 7: Website loads forever on a particular browser'

gcloud beta pubsub topics publish spikey_customer_service --message 'Issue 8: Order is not delivered.'

gcloud beta pubsub subscriptions pull --auto-ack spikey_customer_service_sub1

gcloud beta pubsub subscriptions seek spikey_customer_service_sub1 --time=$(date -u -d '+10 min' +$TS_FORMAT)

gcloud beta pubsub subscriptions pull --auto-ack spikey_customer_service_sub1



ttps://search.google.com/search-console/welcome
 
https://us-central1-spikey-ps.cloudfunctions.net/spikey_issues_logs  

<html><head><meta name="google-site-verification" content="wo4lY1PIFFa8ogsdvxkDRiGnRNpWi1C0zfEjAC0HJdM" /></head><body></body></html>

google-cloud-storage

spikey-data-store

{
  "message": {
    "attributes": {
      "key": "value"
    },
    "data": "SGVsbG8gQ2xvdWQgUHViL1N1YiEgSGVyZSBpcyBteSBtZXNzYWdlIQ==",
    "message_id": "136969346945"
  },
  "subscription": "projects/myproject/subscriptions/mysubscription"
}




export PS1="\[\e[34m\]\w\[\e[m\]>\n-->"


cd pubsub_files

ls -n 

python stackdriver_trigger.py


https://mail.google.com/mail




# export the ps1 file 
export PS1="\[\e[34m\]\w\[\e[m\]>\n-->"

#show the file 
ls -n spikey-ps.json

#export the service file 
export GOOGLE_APPLICATION_CREDENTIALS=~/spikey-ps.json 

echo $GOOGLE_APPLICATION_CREDENTIALS
# Now install the pubsub module 
sudo pip install --upgrade google-cloud-pubsub

gcloud pubsub topics list

#create a topic 
gcloud pubsub topics create spikey_bug_report

gcloud pubsub subscriptions create spikey_bug_report_sub --topic spikey_bug_report

cd pubsub_python_files

ls -n

#first run the publisher.py
python spikey_publisher.py

#Then, run the subscriber.py in the same terminal 
python spikey_subscriber.py

python spikey_publisher_callback.py


python spikey_subscriber_custom_attributes.py

python spikey_publisher_custom_attributes.py


python spikey_publisher_flow_control.py

#try showing that only five messages are retrieved 
python spikey_subscriber_flow_control.py

ls -n


python spikey_subscriber.py

TS_FORMAT=%Y-%m-%dT%H:%M:%SZ

gcloud beta pubsub subscriptions seek spikey_bug_report_sub --time=$(date -u -d '+10 min' +$TS_FORMAT)

python spikey_subscriber.py

python spikey_publisher_batch.py



export GOOGLE_APPLICATION_CREDENTIALS=~/spikey-ps.json

export PS1="\[\e[34m\]\w\[\e[m\]>\n-->"


# pull the 
gcloud pubsub subscriptions pull --auto-ack spikey_chatbot_sub 


sudo pip install --upgrade google-cloud-pubsub

sudo pip install oauth2client==3.0.0

sudo pip install TextBlob

- run the bot.py 

cd pubsub_chatbot

ls -n

python bot.py

timestamp:TIMESTAMP,product_name:STRING,price:FLOAT,units_sold:INTEGER,revenue:FLOAT

cd pubsub_stream

export PS1="\[\e[34m\]\w\[\e[m\]>\n-->"

ls -n

export GOOGLE_CLOUD_PROJECT=~/spikey-ps.json

gcloud pubsub topics create spikey_stream_sales


sudo pip install apache-beam[gcp]

sudo pip install oauth2client==3.0.0

sudo pip install httplib2==0.9.2


ls -n

python product_sales_to_bigquery.py --input_topic projects/spikey-ps/topics/spikey_stream_sales  \
                                    --project spikey-ps \
                                    --temp_location gs://spikey-data-store/tmp/ \
                                    --staging_location gs://spikey-data-store/staging/ \
                                    --runner DataflowRunner

select * from spikey.product_sales

select * from spikey_sales.product_table WHERE 
units_sold = (select max(units_sold) FROM  spikey_sales.product_table ) ; 


select * from spikey_sales.product_table WHERE  
units_sold = (select min(units_sold) FROM  spikey_sales.product_table ) ; 

