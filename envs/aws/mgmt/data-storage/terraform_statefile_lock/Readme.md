# DynamoDB Remote State Locking Example

This folder contains example [Terraform](https://www.terraform.io/) templates that an [S3](https://aws.amazon.com/s3/)
bucket in an [Amazon Web Services (AWS) account](http://aws.amazon.com/). 

The S3 bucket can be used for [remote state
storage](https://www.terraform.io/docs/state/remote/).

For more info, please see Chapter 3, "How to Manage Terraform State", of 
*[Terraform: Up and Running](http://www.terraformupandrunning.com)*.

## Pre-requisites

* You must have [Terraform](https://www.terraform.io/) installed on your computer. 
* You must have an [Amazon Web Services (AWS) account](http://aws.amazon.com/).

Please note that this code was written for Terraform 0.8.x.

## Quick start

**Please note that this example will deploy real resources into your AWS account. We have made every effort to ensure 
all the resources qualify for the [AWS Free Tier](https://aws.amazon.com/free/), but we are not responsible for any
charges you may incur.** 

Configure your [AWS access 
keys](http://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) as 
environment variables:


You may want to create a ~/.aws/credentials configuring keys the `default` parameter to the SANDBOX account:

```hcl

[default]
aws_access_key_id = SANDBOX-ACCESS-KEY-HERE 
aws_secret_access_key = SANDBOX-YOUR-SECRET-KEY-HERE 
aws_region = "us-east-1"
[dev]
aws_access_key_id = ENTER-YOUR-ACCESS-KEY-HERE
aws_secret_access_key = ENTER-YOUR-SECRET-KEY-HERE
aws_region = "us-east-1"
[production]
aws_access_key_id = ENTER-YOUR-ACCESS-KEY-HERE
aws_secret_access_key = ENTER-YOUR-SECRET-KEY-HERE
aws_region = "us-east-1"


```
You may want to specify a name for your bucket in `statefile.tf` using the `default` parameter:

```hcl
terraform {
  backend "s3" {
    bucket = "diversey_sandbox_terraform_statefile"
    key    = "global/s3"
    region = "us-east-1"
    encrypt = true
    profile = "default"
  }
}


```
You can specify this in your output.tf to see which bucket it is using as a backend:
```
output "s3_bucket_arn" {
  value = "${aws_s3_bucket.terraform_state.arn}"
}


```

Validate the templates:

```
terraform plan
```

Deploy the code:

```
terraform apply
```

Clean up when you're done:

```
terraform destroy

