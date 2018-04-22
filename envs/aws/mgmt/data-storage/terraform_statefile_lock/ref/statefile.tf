terraform {
  backend "s3" {
    bucket = "diversey_sandbox_terraform_statefile"
    key    = "global/s3"
    region = "us-east-1"
    encrypt = true
    profile = "default"
  }
}

