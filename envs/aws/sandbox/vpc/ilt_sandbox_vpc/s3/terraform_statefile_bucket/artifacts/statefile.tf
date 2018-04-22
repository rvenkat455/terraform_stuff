terraform {
  backend "s3" {
    bucket = "diversey_sandbox_ilt_sandbox_vpc_terraform_statefile"
    key    = "awssandboxvpcilt_sandbox_vpcs3terraform_statefile_bucket"
    dynamodb_table = "terraform-lock"
    region = "us-east-1"
    encrypt = true
    profile = "default"
  }
}
