terraform {
  backend "s3" {
    bucket = "diversey_sandbox_pac_pipeline_vpc_terraform_statefile"
    key    = "awssandboxvpcpac_pipeline_vpcs3terraform_statefile_bucket"
    dynamodb_table = "terraform-lock"
    region = "us-east-1"
    encrypt = true
    profile = "default"
  }
}
