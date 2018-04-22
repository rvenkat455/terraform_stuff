#variable "cluster_name" {
#  description = "The name to use for all cluster resources"
#}
variable "region" {
  default = "us-east-1"
}

variable "profile" {
  description = "AWS credentials profile you want to use (Example: default) "
}

variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket used for the database's remote state storage (Example: diversey_sandbox_terraform_statefile )"
}

variable "db_remote_state_key" {
  description = "The name of the key in the S3 bucket used for the database's remote state storage (Example: global/s3 ) "
}

variable "db_state_lock_dynDB" {
  description = "This is the state locking DynamoDB table NAME(example: terraform-lock )"
}
