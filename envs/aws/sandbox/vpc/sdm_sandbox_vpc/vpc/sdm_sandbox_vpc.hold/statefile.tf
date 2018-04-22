terraform {
  backend "s3" {
    bucket = "diversey_sandbox_sdm_sandbox_vpc_terraform_statefile"
    key    = "awssandboxvpcsdm_sandbox_vpcs3terraform_statefile_bucket"
    dynamodb_table = "terraform-lock"
    region = "us-east-1"
    encrypt = true
    profile = "default"
  }
}
