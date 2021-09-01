#!/bin/bash
# https://blog.doit-intl.com/optimize-data-transfer-between-compute-engine-and-cloud-storage-9a1ecd030e30

# with out -m and with out pcu
start_ts=$(date +"%s")
gsutil cp -r /home/anjaiahsprcloud/data/* gs://iwinner-data-coldline/withoutMwithoutPCU
end_ts=$(date +"%s")
echo "difference with out -m and with out pcu seconds="$(($end_ts-$start_ts)) >>withoutMwithoutPCU.txt

# with out -m and with pcu 
start_ts=$(date +"%s")
gsutil -o GSUtil:parallel_composite_upload_threshold=150M cp -r /home/anjaiahsprcloud/data/* gs://iwinner-data-coldline/withoutMwithPCU
end_ts=$(date +"%s")
echo "difference with out -m and with pcu  seconds="$(($end_ts-$start_ts)) >>withoutMwithPCU.txt


# with -m and with out pcu 
start_ts=$(date +"%s")
gsutil -m cp -r /home/anjaiahsprcloud/data/* gs://iwinner-data-coldline/withMwithOutPCU
end_ts=$(date +"%s")
echo "difference with -m and with out pcu  seconds="$(($end_ts-$start_ts)) >>withMwithOutPCU.txt


# with -m and with -pcu 
start_ts=$(date +"%s")
gsutil -o GSUtil:parallel_composite_upload_threshold=150M -m cp -r /home/anjaiahsprcloud/data/* gs://iwinner-data-coldline/ALL
end_ts=$(date +"%s")
echo "difference with -m and with -pcu seconds="$(($end_ts-$start_ts)) >>ALL.txt





  

anjaiahsprcloud@cloudshell:~/gsutil_perforamace_test (iwinner-data)$ more withoutMwithoutPCU.txt
difference with out -m and with out pcu seconds=124
anjaiahsprcloud@cloudshell:~/gsutil_perforamace_test (iwinner-data)$ more withoutMwithPCU.txt
difference with out -m and with pcu  seconds=131
anjaiahsprcloud@cloudshell:~/gsutil_perforamace_test (iwinner-data)$ more withMwithOutPCU.txt
difference with -m and with out pcu  seconds=9
anjaiahsprcloud@cloudshell:~/gsutil_perforamace_test (iwinner-data)$ more ALL.txt
difference with -m and with -pcu seconds=14
anjaiahsprcloud@cloudshell:~/gsutil_perforamace_test (iwinner-data)$  
  