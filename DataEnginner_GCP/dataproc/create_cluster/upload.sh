#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: ./upload.sh  bucket-name"
    exit
fi

PROJECT=$(gcloud config get-value project)
BUCKET=$1
INSTALL=gs://$BUCKET/install.sh

#upload install 
gsutil cp install.sh $INSTALL
