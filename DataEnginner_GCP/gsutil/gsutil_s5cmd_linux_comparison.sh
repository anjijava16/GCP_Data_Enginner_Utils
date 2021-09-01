# Using Debian GNU/Linux 10 (buster)

# Create local SSD file system and mount
sudo mkfs.ext4 -F /dev/nvme0n1
sudo mkdir -p /mnt/disks/nvme0n1
sudo mount /dev/nvme0n1 /mnt/disks/nvme0n1
sudo chmod a+w /mnt/disks/nvme0n1
cd /mnt/disks/nvme0n1

# Update
sudo apt-get update
sudo apt-get -y upgrade

##### Testing gsutil with a large file #####

# Create large dataset
fallocate -l 30G temp_30GB_file

# Test upload from local SSD
time gsutil cp temp_30GB_file gs://doit-speed-test-bucket/
# n2-standard-4: 2m21.893s, 216.50 MB/s
# n2-standard-80: 2m11.676s, 233.30 MB/s

time gsutil -m cp temp_30GB_file gs://doit-speed-test-bucket/
# n2-standard-4: 2m48.710s, 182.09 MB/s
# n2-standard-80: 2m29.348s, 205.69 MB/s

time gsutil -o GSUtil:parallel_composite_upload_threshold=150M cp temp_30GB_file gs://doit-speed-test-bucket/
# n2-standard-4: 1m40.104s, 306.88 MB/s
# n2-standard-80: 0m52.145s, 589.13 MB/s

time gsutil -m -o GSUtil:parallel_composite_upload_threshold=150M cp temp_30GB_file gs://doit-speed-test-bucket/
# n2-standard-4: 1m44.579s, 293.75 MB/s
# n2-standard-80: 0m51.154s, 600.54 MB/s

# Test download to local SSD
time gsutil cp gs://doit-speed-test-bucket/temp_30GB_file .
# n2-standard-4: 8m3.186s, 63.58 MB/s
# n2-standard-80: 6m13.585, 82.23 MB/s

time gsutil -m cp gs://doit-speed-test-bucket/temp_30GB_file .
# n2-standard-4: 7m57.881s, 64.28 MB/s
# n2-standard-80: 6m20.131s, 80.81 MB/s


##### Testing s5cmd with a large file #####

# Install required packages
sudo apt-get -y install git wget unzip

# Install and configure AWS CLI with GCS Interoperability credentials
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf aws*
aws configure
# Enter the Access and Secret Access key for the service account

# Install go
wget https://golang.org/dl/go1.15.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.15.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
rm -f go1.15.linux-amd64.tar.gz
go version

# Install s5cmd
# Note: GCS multipart upload isn't supported as GCS Interoperability doesn't support S3's multipart upload API, causing large file uploads to fail unless you provide '-p=1000000':
# https://github.com/peak/s5cmd/issues/217
# https://github.com/peak/s5cmd/issues/29
go get github.com/peak/s5cmd

# Test upload from local SSD
time s5cmd --endpoint-url https://storage.googleapis.com cp -c=1 -p=1000000 temp_30GB_file s3://doit-speed-test-bucket/
# n2-standard-4: 6m7.459s, 83.60 MB/s
# n2-standard-80: 6m50.272s, 74.88 MB/s

time s5cmd --endpoint-url https://storage.googleapis.com cp -p=1000000 temp_30GB_file s3://doit-speed-test-bucket/
# n2-standard-4: 7m18.682s, 70.03 MB/s
# n2-standard-80: 6m48.380s, 75.22 MB/s


# Test download to local SSD
time s5cmd --endpoint-url https://storage.googleapis.com cp -c=1 -p=1000000 s3://doit-speed-test-bucket/temp_30GB_file .
# n2-standard-4: 1m56.170s, 264.44 MB/s
# n2-standard-80: 1m46.196s, 289.28 MB/s

time s5cmd --endpoint-url https://storage.googleapis.com cp -c=1 s3://doit-speed-test-bucket/temp_30GB_file .
# n2-standard-4: 3m21.380s, 152.55 MB/s
# n2-standard-80: 3m45.414s, 136.28 MB/s

time s5cmd --endpoint-url https://storage.googleapis.com cp -p=1000000 s3://doit-speed-test-bucket/temp_30GB_file .
# n2-standard-4: 2m33.148s, 200.59 MB/s
# n2-standard-80: 2m48.071s, 182.78 MB/s

time s5cmd --endpoint-url https://storage.googleapis.com cp s3://doit-speed-test-bucket/temp_30GB_file .
# n2-standard-4: 1m46.378s, 288.78 MB/s
# n2-standard-80: 2m1.116s, 253.64 MB/s





##### Testing gsutil with many small files #####

# Create ~50,001 small files, each 630 KBs in size
mkdir parts
split -b 644245 temp_30GB_file
mv x* parts/

# Test upload from local SSD
nohup bash -c 'time gsutil cp -r parts/* gs://doit-speed-test-bucket/smallparts/' &
# n2-standard-4: 71m30.420s, 7.16 MB/s
# n2-standard-80: 69m32.803s, 7.36 MB/s

nohup bash -c 'time gsutil -m cp -r parts/* gs://doit-speed-test-bucket/smallparts/' &
# n2-standard-4: 9m7.045s, 56.16 MB/s
# n2-standard-80: 3m41.081s, 138.95 MB/s


# Test download to local SSD
nohup bash -c 'time gsutil cp -r gs://doit-speed-test-bucket/smallparts/ parts/' &
# n2-standard-4: 61m24.516s, 8.34 MB/s
# n2-standard-80: 56m54.841s, 9.00 MB/s

nohup bash -c 'time gsutil -m cp -r gs://doit-speed-test-bucket/smallparts/ parts/' &
# n2-standard-4: 7m42.249s, 66.46 MB/s
# n2-standard-80: 3m38.421s, 140.65 MB/s




##### Testing s5cmd download with many small files #####

# Test download to local SSD
nohup bash -c 'time s5cmd --endpoint-url https://storage.googleapis.com cp s3://doit-speed-test-bucket/smallparts/* parts/' &
# n2-standard-4: 1m15.615s, 406.27 MB/s
# n2-standard-80: 1m31.592s, 335.40 MB/s

nohup bash -c 'time s5cmd --endpoint-url https://storage.googleapis.com cp -c=80 s3://doit-speed-test-bucket/smallparts/x* parts/' &
# n2-standard-80: 1m29.837s, 341.95 MB/s