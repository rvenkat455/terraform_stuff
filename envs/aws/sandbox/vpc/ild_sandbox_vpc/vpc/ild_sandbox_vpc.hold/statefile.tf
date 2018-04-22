terraform {
  backend "s3" {
    bucket = "diversey_sandbox_ild_sandbox_vpc_fixed_terraform_statefile"
    key    = "awssandboxvpcild_sandbox_vpc_fixeds3terraform_statefile_bucket"
    dynamodb_table = "terraform-lock"
    region = "us-east-1"
    encrypt = true
    profile = "default"
  }
}
