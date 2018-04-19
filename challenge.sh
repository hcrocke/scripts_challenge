#!/bin/bash

CURRENT_TIME=$(date "+%Y.%m.%d-%H.%M.%S")
BUCKET_NAME="$CURRENT_TIME-hannah-crocker-backups"

echo "creating bucket with name $BUCKET_NAME"

aws s3 mb s3://$BUCKET_NAME --region us-west-1

echo "changing directories"

cd /Users/hannahcrocker/Documents/CodingNomads/scripts/challenge/scripting_challenge

echo "copying files to s3"

aws s3 cp /Users/hannahcrocker/Documents/CodingNomads/scripts/challenge/scripting_challenge s3://$BUCKET_NAME --recursive --exclude "*" --include "*.txt"

aws s3 cp /Users/hannahcrocker/Documents/CodingNomads/scripts/challenge/scripting_challenge s3://$BUCKET_NAME --recursive --exclude "*" --include "*.jpg"

echo "S3 transfer complete"

echo "deleting contents of current directory..."

rm -rf /Users/hannahcrocker/Documents/CodingNomads/scripts/challenge/scripting_challenge/*

echo "creating new directory..."

mkdir $CURRENT_TIME

echo "moving into new directory..."

cd $CURRENT_TIME

echo "copying files from S3 back to local machine..."

aws s3 cp s3://$BUCKET_NAME . --recursive

echo "transfer complete."
  
echo "script complete."
