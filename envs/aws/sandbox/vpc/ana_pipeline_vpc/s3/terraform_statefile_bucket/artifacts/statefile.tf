terraform {
  backend "s3" {
    bucket = "diversey_sandbox_ana_pipeline_vpc_terraform_statefile"
    key    = "awssandboxvpcana_pipeline_vpcs3terraform_statefile_bucket"
    dynamodb_table = "terraform-lock"
    region = "us-east-1"
    encrypt = true
    profile = "default"
  }
}
