https://www.linkedin.com/pulse/pushing-google-cloud-storage-past-limit-scott-edenbaum/
bq extract --noprint_header  bigquery-public-data:stackoverflow.comments gs://edenbaum-storage/stackoverflow-*.csv
# extract BigQuery table "comments" in "stackoverflow" dataset
# omit field headers
# save the files with the wildcard character ensuring the table is evenly split into multiple files 
# example bucket & csv file names: gs://edenbaum-storage/stackoverflow-*.csv


gsutil compose gs://edenbaum-storage/stackoverflow-* gs://edenbaum-storage/combined_stackoverflow.csv
# the compose function is passed a series of input files and an output file
# gs://edenbaum-storage/stackoverflow-* are the 35 < 1gB csv files
# gs://edenbaum-storage/combined_stackoverflow.csv is the intended destination for the single combined csv file


####################################

#!/usr/bin/env bash

#The purpose of this script is to compose all csv files in a given google cloud storage bucket

GSINPUT=$1
FILENAME=$2

Green='\033[0;92m'
Blue='\033[0;94m'
NC='\033[0m'
COUNT=0

linebreak () {
# convienent function to print multiple lines of repeating '-'
lines=$1
for ((i=1; i<=${lines}; i++));do echo "-----------------------------------------------------------";done
}

gscompose () {
# recursive function to keep composing 30 files at a time, then composes the results 30 at a time...
gsinput=$1
iter=$2
filename=$3

echo
echo -e "${Green}Executing Recursive Composition Function${NC}"
echo

gsarray=($(gsutil ls ${gsinput}/${filename}*.csv)) #gather input files to bash array
gssize="${#gsarray[@]}" #get number of files in array

a="$((gssize/30))" # integer division by 30 to find number of full composes needed
b="$((gssize%30))" # mod 30 to find if 1 more compose is necessary

echo -e "${Green}Checking file counts...${NC}"
echo

# increment value "a" if b > 0 to account for remainder of < 30 files
if [ $b -gt 0 ]
then
  a=$((a+1))
fi

echo "Iteration: ${iter} - Compose Loops Remaining: ${a}"
echo
echo -e "${Blue}Compose loop started${NC}"
echo

for ((i=1; i<=${a}; i++))
do
    st=$((0+(${i}-1)*30))
    ed=$((${st}+30))
    echo "Compose files:"
    echo "${gsarray[@]:${st}:${ed}}"
    echo
    gsutil compose ${gsarray[@]:$st:$ed} ${gsinput}/${FILENAME}-${iter}-${i}.csv
    COMPOSEFILE="${gsinput}/${FILENAME}-${iter}-${i}.csv"
done

echo -e "${Green}Compose loop finished${NC}"
linebreak 1
echo

# check if latest compose is multiple files, then recursively run gscompose
gsarraytmp=($(gsutil ls ${gsinput}/${filename}-${iter}*.csv))

if [ ${#gsarraytmp[@]} -gt 1 ]
then
	COUNT=$((COUNT+1)) #increment COUNT - aka $iter
	gscompose ${GSINPUT} ${COUNT} ${filename}-${iter} # recursive function call - change input $3 - $filename to reflect current iteration
else
	linebreak 1
	echo -e "${Green}Done! - ${COMPOSEFILE}${NC}"
	linebreak 1
	# exit script when there are no more files to compose
	exit 0
fi		
}

linebreak 1
echo -e "${Green}Google Cloud Storage directory: ${GSINPUT}${NC}"
echo -e "${Green}Filename prefix: ${FILENAME}${NC}"
linebreak 1
echo

echo -e "${Green}Starting Compose Script ${NC}"
gscompose ${GSINPUT} ${COUNT} ${FILENAME}
