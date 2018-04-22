terraform {
  backend "s3" {
    bucket = "diversey_sandbox_terraform_statefile"
    key    = "global/s3"
    dynamodb_table = "terraform-lock"
    region = "us-east-1"
    encrypt = true
    profile = "default"
  }
}

