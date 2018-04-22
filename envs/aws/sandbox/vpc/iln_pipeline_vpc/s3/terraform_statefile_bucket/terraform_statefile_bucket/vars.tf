variable "bucket_name" {
  description = "The name of the S3 bucket. Must be globally unique.\n   (Example: diversey_sandbox_POC_terraform_statefile ) Replace sandbox with dev/stg/prod and  POC with PROJECT 3 Letter ID"
}
variable "region" {
        default = "us-east-1"
}
variable "profile" {
    description = "AWS credentials profile you want to use. (Example: default )"
}

