#!/bin/bash

# Script to initialize an S3 tfstate file for a specific project. 
# This file is unique for each project/resource.   
# Some are global like the VPC configuration, others are not like the EC2 instance config.  
# Use some sense and seperate when needed, do not bury VPC stuff in your cluster creation for a webserver.


ENV=$(pwd |sed 's/.*\/envs//g'|awk -F "/" '{print $(NF-4)}')
PROJECT=$(pwd |sed 's/.*\/envs//g'|awk -F "/" '{print $(NF-2)}')
KEY=$(pwd |sed 's/.*\/envs//g'|sed 's/\///g' )
STATELOCKDB='terraform-lock'
# Statefile used in this project.

SF="artifacts/statefile.tf"


echo -e "Type the name of the S3 bucket. Must be globally unique.\n   (Example: diversey_${ENV}_${PROJECT}_terraform_statefile )\n    Replace parts with dev/stg/prod and  POC with PROJECT 3 Letter ID\n followed by [ENTER]:"

read bucket_name 

echo "Bucket Name: ${bucket_name}"


if [[ ! ${bucket_name} || ${bucket_name} = *[^0-9a-zA-Z_-]* ]]; then
    echo "Error: '${bucket_name}' is not a valid bucket." >&2
    exit 1
fi

terraform init -var "bucket_name=${bucket_name}" -var 'profile=default'
terraform plan  -var "bucket_name=${bucket_name}" -var 'profile=default'



while true; do
    read -p "Should we proceed with the above change? (y/n)?" yn
    case $yn in
        [Yy]* ) terraform apply -var "bucket_name=${bucket_name}" -var 'profile=default'; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done


echo "terraform {" > ${SF}
echo "  backend \"s3\" {" >> ${SF}
echo "    bucket = \"${bucket_name}\"" >> ${SF}
echo "    key    = \"${KEY}\""  >> ${SF}
echo "    dynamodb_table = \"${STATELOCKDB}\"" >> ${SF}
echo "    region = \"us-east-1\"" >> ${SF}
echo "    encrypt = true" >> ${SF}
echo "    profile = \"default\"" >> ${SF}
echo "  }" >> ${SF}
echo "}" >> ${SF}

