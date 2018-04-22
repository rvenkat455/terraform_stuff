terraform {
  backend "s3" {
    bucket = "diversey_sandbox_dqa_uat_vpc_terraform_statefile"
    key    = "awssandboxvpcdqa_uat_vpcs3terraform_statefile_bucket"
    dynamodb_table = "terraform-lock"
    region = "us-east-1"
    encrypt = true
    profile = "default"
  }
}
